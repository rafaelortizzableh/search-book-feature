import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../book_search_export.dart';

class BookSearchStateNotifier extends StateNotifier<BookSearchState> {
  BookSearchStateNotifier(
    BookSearchState state,
    this._bookSearchService,
    this._favoriteBooksService,
  ) : super(state) {
    getFavoriteBooks();
  }
  final BookSearchService _bookSearchService;
  final FavoriteBooksService _favoriteBooksService;

  Future<void> searchForBooks(String search) async {
    state = state.copyWith(books: const AsyncValue.loading());
    final result = await _bookSearchService.searchBooks(search);
    result.when(
        (error) => state = state.copyWith(books: AsyncValue.error(error)),
        (data) => state = state.copyWith(books: AsyncValue.data(data)));
  }

  void saveSearch(String search) async {
    state = state.copyWith(searches: const AsyncValue.loading());
    await _bookSearchService.addUserSearch(search);
    final searches = _bookSearchService.getPreviousSearches;
    state = state.copyWith(searches: AsyncValue.data(searches ?? []));
  }

  Future<void> removeSearch(String search) async {
    state = state.copyWith(searches: const AsyncValue.loading());
    await _bookSearchService.removeUserSearch(search);
    final searches = _bookSearchService.getPreviousSearches;
    state = state.copyWith(searches: AsyncValue.data(searches ?? []));
  }

  Future<void> addBooktoFavorites(Book book) async {
    final result = await _favoriteBooksService.addBookToFavorites(book);
    result.when(
      (error) => state = state.copyWith(
        error: error,
      ),
      (data) => state = state.copyWith(
        favoriteBooks: AsyncValue.data(data),
      ),
    );
  }

  Future<void> getFavoriteBooks() async {
    final result = await _favoriteBooksService.getFavoriteBooks();
    result.when(
        (error) =>
            state = state.copyWith(favoriteBooks: AsyncValue.error(error)),
        (data) => state = state.copyWith(favoriteBooks: AsyncValue.data(data)));
  }

  Future<void> removeFavoriteBook(Book book) async {
    final result = await _favoriteBooksService.removeBookFromFavorites(book);
    result.when(
      (error) => state = state.copyWith(
        error: error,
      ),
      (data) => state = state.copyWith(
        favoriteBooks: AsyncValue.data(data),
      ),
    );
  }
}
