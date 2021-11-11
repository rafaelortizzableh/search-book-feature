import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/core.dart';
import '../../book_search_export.dart';

class FavoriteBooksScreen extends ConsumerWidget {
  const FavoriteBooksScreen({Key? key}) : super(key: key);
  static const routeName = '/favorites';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _translations = AppLocalizations.of(context);
    final _bookSearchFavoriteBooks =
        ref.watch(bookSearchControllerProvider).favoriteBooks;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('${_translations?.favorite_books}')),
      body: _bookSearchFavoriteBooks.when(
        data: (books) {
          return books.isNotEmpty
              ? _BookList(books: books)
              : const _NoFavoriteBooks();
        },
        error: (error, _) {
          return FailureBody(message: error.toString());
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class _BookList extends StatelessWidget {
  const _BookList({Key? key, required this.books}) : super(key: key);
  final List<Book> books;
  static const _paddings8 = 8.0;
  static const _size45 = 45.0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(_paddings8),
      itemBuilder: (context, index) {
        final Book book = books[index];

        return ListTile(
          onTap: () => BookSearchUiFunctions.showDialogWidget(
              context, BookDetail(book: book)),
          title:
              (Text(book.title, maxLines: 2, overflow: TextOverflow.ellipsis)),
          leading: SizedBox(
            width: _size45,
            height: _size45,
            child: ClipOval(
              child: NetworkFadingImage(path: book.imageLinks.thumbNail),
            ),
          ),
          trailing: Consumer(builder: (context, ref, _) {
            return IconButton(
                onPressed: () async =>
                    await BookSearchUiFunctions.removeFavorite(ref, book),
                icon: const Icon(Icons.favorite, color: Colors.red));
          }),
          subtitle: book.authors.isNotEmpty
              ? Text(book.authors.first)
              : const SizedBox(),
        );
      },
      itemCount: books.length,
    );
  }
}

class _NoFavoriteBooks extends StatelessWidget {
  const _NoFavoriteBooks({Key? key}) : super(key: key);
  static const _padding16 = 16.0;

  @override
  Widget build(BuildContext context) {
    final _translations = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(_padding16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('${_translations?.no_favorite_books}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: _padding16),
            Consumer(
              builder: (context, ref, _) {
                return ElevatedButton.icon(
                    onPressed: () =>
                        BookSearchUiFunctions.showSearchModal(context, ref),
                    icon: const Icon(Icons.search),
                    label: Text('${_translations?.searchBook}'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
