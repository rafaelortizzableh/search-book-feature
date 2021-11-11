import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/core.dart';
import '../book_search_export.dart';

class BookSearchStateNotifier extends StateNotifier<BookSearchState> {
  BookSearchStateNotifier(BookSearchState state, this._bookSearchService,
      this._sharedPreferencesService, this._favoriteBooksService)
      : super(state) {
    getFavoriteBooks();
  }
  final BookSearchService _bookSearchService;
  final FavoriteBooksService _favoriteBooksService;
  final SharedPreferencesService _sharedPreferencesService;

  Future<void> searchForBooks(String search) async {
    state = state.copyWith(books: const AsyncValue.loading());
    final result = await _bookSearchService.searchBooks(search);
    result.when(
        (error) => state = state.copyWith(books: AsyncValue.error(error)),
        (data) => state = state.copyWith(books: AsyncValue.data(data)));
  }

  void saveSearch(String search) async {
    state = state.copyWith(searches: const AsyncValue.loading());
    await _sharedPreferencesService.addUserSearch(search);
    final searches = _sharedPreferencesService.getPreviousSearches;
    state = state.copyWith(searches: AsyncValue.data(searches ?? []));
  }

  Future<void> removeSearch(String search) async {
    state = state.copyWith(searches: const AsyncValue.loading());
    await _sharedPreferencesService.removeUserSearch(search);
    final searches = _sharedPreferencesService.getPreviousSearches;
    state = state.copyWith(searches: AsyncValue.data(searches ?? []));
  }

  Future<void> addBooktoFavorites(Book book) async {
    state = state.copyWith(favoriteBooksIds: const AsyncValue.loading());
    await _sharedPreferencesService.addFavoriteBook(book.id);
    final favoriteBooks = _sharedPreferencesService.getFavoriteBooks;
    final result = await _favoriteBooksService.addBookToFavorites(book);
    result.when(
        (error) => state = state.copyWith(
            favoriteBooksIds: AsyncValue.data(favoriteBooks ?? [])),
        (data) => state = state.copyWith(
            favoriteBooksIds: AsyncValue.data(favoriteBooks ?? []),
            favoriteBooks: AsyncValue.data(data)));
  }

  Future<void> getFavoriteBooks() async {
    final result = await _favoriteBooksService.getFavoriteBooks();
    result.when(
        (error) =>
            state = state.copyWith(favoriteBooks: AsyncValue.error(error)),
        (data) => state = state.copyWith(favoriteBooks: AsyncValue.data(data)));
  }

  Future<void> removeFavoriteBook(Book book) async {
    state = state.copyWith(favoriteBooksIds: const AsyncValue.loading());
    await _sharedPreferencesService.removeFavoriteBook(book.id);
    final favoriteBooks = _sharedPreferencesService.getFavoriteBooks;
    final result = await _favoriteBooksService.removeBookFromFavorites(book);
    result.when(
        (error) => state = state.copyWith(
            favoriteBooksIds: AsyncValue.data(favoriteBooks ?? [])),
        (data) => state = state.copyWith(
            favoriteBooksIds: AsyncValue.data(favoriteBooks ?? []),
            favoriteBooks: AsyncValue.data(data)));
  }
}
