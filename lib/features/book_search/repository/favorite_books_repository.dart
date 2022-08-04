import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/core.dart';
import '../book_search_export.dart';

final favoriteBooksRepositoryProvider = Provider<FavoriteBooksRepository>(
    (ref) => SharedPreferencesFavoriteBooksRepository(ref.read));

abstract class FavoriteBooksRepository {
  Future<List<Book>> getFavoriteBooks();
  Future<List<Book>> addBookToFavorites(Book book);
  Future<List<Book>> removeFromFavorites(Book book);
}

class HiveFavoriteBooksRepository implements FavoriteBooksRepository {
  @override
  Future<List<Book>> getFavoriteBooks() async {
    try {
      final _booksBox = await Hive.openBox<Book>('favoriteBooks');
      final _books = _booksBox.values.toList();
      await _booksBox.close();
      return _books;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  @override
  Future<List<Book>> addBookToFavorites(Book book) async {
    try {
      final List<Book> _books = [];
      final _booksBox = await Hive.openBox<Book>('favoriteBooks');

      final _timeStamp = DateTime.now();
      await _booksBox.put(
          book.id, book.copyWith(timeStamp: _timeStamp.toString()));
      final _boxBooks = _booksBox.values;
      _books.addAll(_boxBooks);
      await _booksBox.close();
      return _books;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  @override
  Future<List<Book>> removeFromFavorites(Book book) async {
    try {
      final List<Book> _books = [];
      final _booksBox = await Hive.openBox<Book>('favoriteBooks');
      await _booksBox.delete(book.id);
      final _boxBooks = _booksBox.values;
      _books.addAll(_boxBooks);
      await _booksBox.close();
      return _books;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}

class SharedPreferencesFavoriteBooksRepository
    implements FavoriteBooksRepository {
  SharedPreferencesFavoriteBooksRepository(this._read);
  final Reader _read;

  @override
  Future<List<Book>> getFavoriteBooks() async {
    try {
      final _prefs = _read(sharedPreferencesServiceProvider);
      final encodedBooks =
          _prefs.getListOfStringsFromSharedPreferences('spFavoriteBooks');
      if (encodedBooks == null) {
        throw ('No saved Shared Prefs books');
      }
      final books = encodedBooks.map((e) => Book.fromJson(e)).toList();
      return books;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  @override
  Future<List<Book>> addBookToFavorites(Book book) async {
    try {
      final _prefs = _read(sharedPreferencesServiceProvider);
      final encodedBooks =
          _prefs.getListOfStringsFromSharedPreferences('spFavoriteBooks');
      final encodedNewBook = book.toJson();

      final updatedEncodedBooks = [
        ...encodedBooks ?? [],
        encodedNewBook,
      ];

      await _prefs.saveListOfStringsToSharedPreferences(
        'spFavoriteBooks',
        [
          ...encodedBooks ?? [],
          encodedNewBook,
        ],
      );

      return updatedEncodedBooks.map((e) => Book.fromJson(e)).toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  @override
  Future<List<Book>> removeFromFavorites(Book book) async {
    try {
      final _prefs = _read(sharedPreferencesServiceProvider);
      final encodedBooks =
          _prefs.getListOfStringsFromSharedPreferences('spFavoriteBooks');
      final decodedBooks = encodedBooks?.map((e) => Book.fromJson(e));

      final updatedBooks =
          decodedBooks?.where((element) => element.id != book.id) ??
              (decodedBooks ?? <Book>[]);

      await _prefs.saveListOfStringsToSharedPreferences(
        'spFavoriteBooks',
        updatedBooks.map((e) => e.toJson()).toList(),
      );

      return updatedBooks.toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
