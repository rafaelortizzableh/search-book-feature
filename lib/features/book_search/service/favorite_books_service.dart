import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../core/core.dart';
import '../../book_search/book_search_export.dart';

final favoriteBooksServiceProvider = Provider<FavoriteBooksService>((ref) =>
    LocalFavoriteBooksService(ref.watch(favoriteBooksRepositoryProvider)));

abstract class FavoriteBooksService {
  Future<Result<Failure, List<Book>>> getFavoriteBooks();
  Future<Result<Failure, List<Book>>> addBookToFavorites(Book book);
  Future<Result<Failure, List<Book>>> removeBookFromFavorites(Book book);
}

class LocalFavoriteBooksService implements FavoriteBooksService {
  LocalFavoriteBooksService(this._repository);

  final FavoriteBooksRepository _repository;

  @override
  Future<Result<Failure, List<Book>>> addBookToFavorites(Book book) async {
    try {
      return Success(await _repository.addBookToFavorites(book));
    } on Failure catch (failure) {
      return Error(failure);
    }
  }

  @override
  Future<Result<Failure, List<Book>>> removeBookFromFavorites(Book book) async {
    try {
      return Success(await _repository.removeFromFavorites(book));
    } on Failure catch (failure) {
      return Error(failure);
    }
  }

  @override
  Future<Result<Failure, List<Book>>> getFavoriteBooks() async {
    try {
      return Success(await _repository.getFavoriteBooks());
    } on Failure catch (failure) {
      return Error(failure);
    }
  }
}
