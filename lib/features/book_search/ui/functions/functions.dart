import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../book_search/book_search_export.dart';

class BookSearchUiFunctions {
  static const _rounderBorder15 = 15.0;
  static const _opacity095 = 0.95;

  static void navigateToBookDetailsPage(BuildContext context, Book book) {
    Navigator.of(context)
        .pushNamed(BookDetailsScreen.routeName, arguments: book);
  }

  static void submitData(
    TextEditingController _searchController,
    BuildContext context,
  ) {
    final search = _searchController.text;

    Navigator.of(context).pop(search);
  }

  static Future<void> showSearchModal(
      BuildContext context, WidgetRef ref) async {
    String? search = await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_rounderBorder15),
      ),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: const NewSearch(),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
    if (search != null) {
      ref.read(bookSearchControllerProvider.notifier).saveSearch(search);
      searchForBook(search, ref, context);
    }
  }

  static void searchForBook(
      String search, WidgetRef ref, BuildContext context) {
    ref.read(bookSearchControllerProvider.notifier).searchForBooks(search);
    Navigator.of(context).pushNamed(ResultsScreen.routeName);
  }

  static Future<void> removeFavorite(WidgetRef ref, Book book) async {
    ref.read(bookSearchControllerProvider.notifier).removeFavoriteBook(book);
  }

  static Future<void> addFavorite(WidgetRef ref, Book book) async {
    ref.read(bookSearchControllerProvider.notifier).addBooktoFavorites(book);
  }
}
