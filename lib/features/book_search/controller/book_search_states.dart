import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/core.dart';
import '../book_search_export.dart';

@immutable
class BookSearchState {
  final String searchTerm;
  final AsyncValue<List<Book>> books;
  final AsyncValue<List<String>> searches;
  final AsyncValue<List<Book>> favoriteBooks;
  final Failure? error;

  const BookSearchState({
    this.searchTerm = '',
    required this.searches,
    required this.books,
    required this.favoriteBooks,
    this.error,
  });

  BookSearchState copyWith({
    String? searchTerm,
    AsyncValue<List<Book>>? books,
    AsyncValue<List<String>>? searches,
    AsyncValue<List<Book>>? favoriteBooks,
    Failure? error,
  }) {
    return BookSearchState(
      favoriteBooks: favoriteBooks ?? this.favoriteBooks,
      searchTerm: searchTerm ?? this.searchTerm,
      books: books ?? this.books,
      searches: searches ?? this.searches,
      error: error ?? this.error,
    );
  }
}
