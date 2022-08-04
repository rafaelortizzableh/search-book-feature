import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/core.dart';
import '../../book_search_export.dart';

class ResultsScreen extends ConsumerWidget {
  const ResultsScreen({Key? key}) : super(key: key);
  static const routeName = '/results';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _translations = AppLocalizations.of(context);
    final _bookSearchResults = ref.watch(bookSearchControllerProvider).books;

    return Scaffold(
      appBar: AppBar(title: Text('${_translations?.results}')),
      body: _bookSearchResults.when(
        data: (books) {
          return books.isNotEmpty
              ? _BookList(books: books)
              : const _NoBookResults();
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
  static const _size45 = 45.0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final Book book = books[index];

        return ListTile(
          onTap: () => BookSearchUiFunctions.navigateToBookDetailsPage(
            context,
            book,
          ),
          title:
              (Text(book.title, maxLines: 2, overflow: TextOverflow.ellipsis)),
          leading: SizedBox(
            width: _size45,
            height: _size45,
            child: ClipOval(
              child: NetworkFadingImage(path: book.imageLinks.thumbNail),
            ),
          ),
          trailing: Consumer(
            builder: (context, ref, _) {
              final favorites =
                  ref.watch(bookSearchControllerProvider).favoriteBooks.when(
                        data: (favs) => favs,
                        error: (e, _) => <Book>[],
                        loading: () => <Book>[],
                      );

              final isFavorite = book.isFavorite(favorites);

              return IconButton(
                onPressed: isFavorite
                    ? () async =>
                        await BookSearchUiFunctions.removeFavorite(ref, book)
                    : () async =>
                        await BookSearchUiFunctions.addFavorite(ref, book),
                icon: Icon(Icons.favorite,
                    color: !isFavorite ? Colors.grey.shade400 : Colors.red),
              );
            },
          ),
          subtitle: book.authors.isNotEmpty
              ? Text(book.authors.first)
              : const SizedBox(),
        );
      },
      itemCount: books.length,
    );
  }
}

class _NoBookResults extends StatelessWidget {
  const _NoBookResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _translations = AppLocalizations.of(context);
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          '${_translations?.noBooksFound}',
          style: Theme.of(context).textTheme.headline6,
        ),
      ]),
    );
  }
}
