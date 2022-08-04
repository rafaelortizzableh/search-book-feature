import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features/theme/theme_export.dart';
import '../ui_export.dart';

class BookSearchScreen extends ConsumerWidget {
  const BookSearchScreen({Key? key}) : super(key: key);
  static const routeName = '/';
  static const _padding16 = 16.0;
  static const _padding32 = 32.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _translations = AppLocalizations.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(_translations?.appTitle ?? 'Book Search App'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(ThemeScreen.routeName);
          },
          icon: const Icon(Icons.light_mode),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(FavoriteBooksScreen.routeName);
            },
            icon: const Icon(Icons.favorite),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(SearchHistoryScreen.routeName);
            },
            icon: const Icon(Icons.history),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: _padding32,
          horizontal: _padding16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const GreetingWidget(),
            const SizedBox(height: _padding16),
            const Expanded(child: BookImage()),
            const SizedBox(height: _padding16),
            SearchBar(
              onPressed: () =>
                  BookSearchUiFunctions.showSearchModal(context, ref),
            ),
          ],
        ),
      ),
    );
  }
}
