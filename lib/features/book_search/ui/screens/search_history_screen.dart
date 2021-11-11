import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../book_search_export.dart';

class SearchHistoryScreen extends ConsumerWidget {
  const SearchHistoryScreen({Key? key}) : super(key: key);
  static const routeName = '/search/history';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _translations = AppLocalizations.of(context);

    var _previousSearches = ref.watch(bookSearchControllerProvider).searches;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text('${_translations?.my_books}')),
        body: _previousSearches.when(
            data: (data) {
              return data.isNotEmpty
                  ? _BookList(bookTitles: data)
                  : const _NoBookSearches();
            },
            error: (error, _) => ErrorWidget(error),
            loading: () {
              return const Center(child: CircularProgressIndicator());
            }));
  }
}

class _BookList extends StatelessWidget {
  const _BookList({Key? key, required this.bookTitles}) : super(key: key);
  final List<String> bookTitles;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final String _bookTitle = bookTitles[index];
        return Consumer(builder: (context, ref, _) {
          return ListTile(
            onTap: () =>
                BookSearchUiFunctions.searchForBook(_bookTitle, ref, context),
            title: (Text(_bookTitle)),
            trailing: Consumer(
              builder: (context, ref, _) {
                return IconButton(
                  onPressed: () => ref
                      .read(bookSearchControllerProvider.notifier)
                      .removeSearch(_bookTitle),
                  icon: const Icon(
                    Icons.delete,
                  ),
                );
              },
            ),
          );
        });
      },
      itemCount: bookTitles.length,
    );
  }
}

class _NoBookSearches extends StatelessWidget {
  const _NoBookSearches({Key? key}) : super(key: key);
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
            Text('${_translations?.no_books_search_history}',
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
