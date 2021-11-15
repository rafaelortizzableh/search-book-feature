import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../book_search_export.dart';

class BookDetail extends StatelessWidget {
  static const _widthFactor033 = 0.33;
  static const _aspectRatio075 = 0.75;
  static const _padding32 = 32.0;
  static const _padding16 = 16.0;
  const BookDetail({Key? key, required this.book}) : super(key: key);
  final Book book;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _size = MediaQuery.of(context).size;
    final _translations = AppLocalizations.of(context);

    return Stack(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: _padding32, vertical: _padding16),
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
                        fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    book.authors.first,
                    style: _theme.textTheme.headline6
                        ?.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: _padding16),
                  Text(
                    book.publishedDateString.isNotEmpty
                        ? '${_translations?.published}${book.publishedDateString}'
                        : '',
                    style: _theme.textTheme.headline6
                        ?.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    book.pageCount > 0
                        ? '${_translations?.pages}: ${book.pageCount}'
                        : '',
                    style: _theme.textTheme.headline6
                        ?.copyWith(color: Colors.white),
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
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: _padding16),
                        Text(
                          book.description,
                          textAlign: TextAlign.justify,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: _padding32,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ),
        Consumer(
          builder: (context, ref, _) {
            final favorites =
                ref.watch(bookSearchControllerProvider).favoriteBooksIds;
            final isFavorite =
                ((favorites.value != null && favorites.value is List<String>) &&
                    (favorites.value!.isNotEmpty &&
                        favorites.value!.contains(book.id)));
            return Positioned(
              right: _padding32,
              child: GestureDetector(
                onTap: isFavorite
                    ? () async =>
                        await BookSearchUiFunctions.removeFavorite(ref, book)
                    : () async =>
                        await BookSearchUiFunctions.addFavorite(ref, book),
                child: isFavorite
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      ),
              ),
            );
          },
        ),
      ],
    );
  }
}
