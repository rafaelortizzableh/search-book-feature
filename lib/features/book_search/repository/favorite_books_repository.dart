import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../book_search_export.dart';

final favoriteBooksRepositoryProvider =
    Provider<FavoriteBooksRepository>((_) => LocalFavoriteBooksRepository());

abstract class FavoriteBooksRepository {
  Future<List<Book>> getFavoriteBooks();
  Future<List<Book>> addBookToFavorites(Book book);
  Future<List<Book>> removeFromFavorites(Book book);
}

class LocalFavoriteBooksRepository implements FavoriteBooksRepository {
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
