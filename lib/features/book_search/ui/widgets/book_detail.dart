import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(_padding32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: _size.width * _widthFactor033,
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
            style: _theme.textTheme.headline5
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: _padding16),
          Text(
            book.authors.first,
            style: _theme.textTheme.headline6?.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          Text(
            book.pageCount > 0
                ? '${_translations?.pages}: ${book.pageCount}'
                : '',
            style: _theme.textTheme.headline6?.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ));
  }
}
