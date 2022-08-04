import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences prefs;

  SharedPreferencesService(this.prefs);

  String? get getUserTheme => prefs.getString('selectedTheme');

  Future<bool> setPreferredTheme(String theme) async {
    try {
      return await prefs.setString('selectedTheme', theme);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  List<String>? get getPreviousSearches =>
      prefs.getStringList('previousSearches');

  Future<bool> addUserSearch(String search) async {
    try {
      final userSearches = prefs.getStringList('previousSearches') ?? [];
      final newList = [...userSearches, search];
      return await prefs.setStringList(
          'previousSearches', newList.toSet().toList());
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<bool> removeUserSearch(String search) async {
    try {
      final userSearches = prefs.getStringList('previousSearches') ?? [];
      if (userSearches.contains(search)) {
        userSearches.remove(search);
      }
      return await prefs.setStringList(
          'previousSearches', userSearches.toSet().toList());
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  List<String>? get getFavoriteBooks => prefs.getStringList('favoriteBooks');

  Future<bool> addFavoriteBook(String bookId) async {
    try {
      final favoriteBooks = prefs.getStringList('favoriteBooks') ?? [];
      final newList = [...favoriteBooks, bookId];
      return await prefs.setStringList(
          'favoriteBooks', newList.toSet().toList());
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<bool> removeFavoriteBook(String bookId) async {
    try {
      final favoriteBooks = prefs.getStringList('favoriteBooks') ?? [];
      if (favoriteBooks.contains(bookId)) {
        favoriteBooks.remove(bookId);
      }
      return await prefs.setStringList(
          'favoriteBooks', favoriteBooks.toSet().toList());
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
