import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../core/core.dart';
import '../../book_search/book_search_export.dart';

final bookSearchServiceProvider = Provider<BookSearchService>(
    (ref) => GoogleBookSearchService(ref.watch(bookSearchRepositoryProvider)));

abstract class BookSearchService {
  Future<Result<Failure, List<Book>>> searchBooks(String search);
}

class GoogleBookSearchService implements BookSearchService {
  GoogleBookSearchService(this._repository);

  final BookSearchRepository _repository;

  @override
  Future<Result<Failure, List<Book>>> searchBooks(String search) async {
    try {
      final _bookEntities = await _repository.searchBooks(search);
      final _books =
          _bookEntities.map((e) => Book.fromEntity(e)).toList(growable: false);
      return Success(_books);
    } on Failure catch (failure) {
      return Error(failure);
    }
  }
}
