import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/core.dart';
import '../../book_search/book_search_export.dart';

final bookSearchRepositoryProvider = Provider<BookSearchRepository>(
    (ref) => GoogleBookSearchRepository(ref.read));

abstract class BookSearchRepository {
  Future<List<BookRemoteEntity>> searchBooks(String search);
  List<String>? get getPreviousSearches;
  Future<bool> addUserSearch(String search);
  Future<bool> removeUserSearch(String search);
}

class GoogleBookSearchRepository implements BookSearchRepository {
  GoogleBookSearchRepository(this._read);
  final Reader _read;

  @override
  Future<List<BookRemoteEntity>> searchBooks(String search) async {
    try {
      final languageCode =
          Localizations.localeOf(AppConstants.navigationKey.currentContext!)
              .languageCode;
      final response =
          await _read(dioProvider).get('volumes', queryParameters: {
        'key': AppConstants.apiKey,
        'q': search,
        'langRestrict': languageCode,
        'printType': 'books',
      });
      final results = List<dynamic>.from(response.data['items']);
      return results.map((book) {
        final String id = book['id'];
        final Map<String, dynamic> volumeInfo = book['volumeInfo'];
        return BookRemoteEntity.fromMapAndId(volumeInfo, id);
      }).toList();
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw Failure(
          message:
              '${AppLocalizations.of(AppConstants.navigationKey.currentContext!)?.noInternetConnection}',
          exception: e,
        );
      }

      throw Failure(
        message: e.response?.statusMessage ?? 'Something went wrong',
        code: e.response?.statusCode,
      );
    }
  }

  @override
  List<String>? get getPreviousSearches =>
      _read(sharedPreferencesServiceProvider)
          .getListOfStringsFromSharedPreferences('previousSearches');
  @override
  Future<bool> addUserSearch(String search) async {
    try {
      final _prefs = _read(sharedPreferencesServiceProvider);
      final userSearches =
          _prefs.getListOfStringsFromSharedPreferences('previousSearches') ??
              [];
      final newList = [...userSearches, search];
      return await _prefs.saveListOfStringsToSharedPreferences(
          'previousSearches', newList.toSet().toList());
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<bool> removeUserSearch(String search) async {
    try {
      final _prefs = _read(sharedPreferencesServiceProvider);
      final userSearches =
          _prefs.getListOfStringsFromSharedPreferences('previousSearches') ??
              [];
      if (userSearches.contains(search)) {
        userSearches.remove(search);
      }
      return await _prefs.saveListOfStringsToSharedPreferences(
          'previousSearches', userSearches.toSet().toList());
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
