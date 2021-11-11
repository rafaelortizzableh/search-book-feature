import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/core.dart';
import '../book_search_export.dart';

// Here we combine providers and give an initial (empty) value for book results
final bookSearchControllerProvider =
    StateNotifierProvider<BookSearchStateNotifier, BookSearchState>((ref) {
  final _sharedPreferencesService = ref.watch(sharedPreferencesServiceProvider);
  final _bookSearchService = ref.watch(bookSearchServiceProvider);
  final _favoriteBooksService = ref.watch(favoriteBooksServiceProvider);
  final _initialState = BookSearchState(
      favoriteBooks: const AsyncValue.data([]),
      books: const AsyncValue.data([]),
      searches:
          AsyncValue.data(_sharedPreferencesService.getPreviousSearches ?? []),
      favoriteBooksIds:
          AsyncValue.data(_sharedPreferencesService.getFavoriteBooks ?? []));
  final _bookSearchController = BookSearchStateNotifier(
    _initialState,
    _bookSearchService,
    _sharedPreferencesService,
    _favoriteBooksService,
  );
  return _bookSearchController;
});
