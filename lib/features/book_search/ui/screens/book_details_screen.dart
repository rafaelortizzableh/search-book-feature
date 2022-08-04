import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

class BookDetailsScreen extends StatelessWidget {
  static const routeName = '/book-details';
  static const _padding16 = 16.0;
  static const _padding32 = 32.0;
  static const _widthFactor033 = 0.33;
  static const _aspectRatio075 = 0.75;

  const BookDetailsScreen({Key? key, required this.book}) : super(key: key);
  final Book book;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _size = MediaQuery.of(context).size;
    final _translations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(book.title),
        actions: [
          Consumer(
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
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: _padding32,
          horizontal: _padding16,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints:
                    BoxConstraints(maxWidth: _size.width * _widthFactor033),
                child: AspectRatio(
                  aspectRatio: _aspectRatio075,
                  child: NetworkFadingImage(
                    path: book.imageLinks.thumbNail,
                  ),
                ),
              ),
              const SizedBox(height: _padding16),
              Text(
                book.title,
                style: _theme.textTheme.headline5?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                book.authors.isNotEmpty ? book.authors.first : '',
                style: _theme.textTheme.headline6?.copyWith(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: _padding16),
              Text(
                book.publishedDateString.isNotEmpty
                    ? '${_translations?.published}${book.publishedDateString}'
                    : '',
                style: _theme.textTheme.headline6,
                textAlign: TextAlign.center,
              ),
              Text(
                book.pageCount > 0
                    ? '${_translations?.pages}: ${book.pageCount}'
                    : '',
                style: _theme.textTheme.headline6,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: _padding16),
              if (book.description.isNotEmpty)
                Column(
                  children: [
                    const SizedBox(height: _padding16),
                    Text(
                      '${_translations?.description}',
                      style: _theme.textTheme.headline6?.copyWith(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: _padding16),
                    Text(
                      book.description,
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
