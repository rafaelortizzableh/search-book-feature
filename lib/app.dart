import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'features/book_search/book_search_export.dart';
import 'features/theme/theme_export.dart';
import 'core/core.dart';

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Builder(
      builder: (BuildContext context) {
        return MaterialApp(
          restorationScopeId: 'app',
          title: 'Movie Recomendation App',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          theme: CustomTheme.lightTheme(),
          darkTheme: CustomTheme.darkTheme(),
          themeMode: ref.watch(themeControllerProvider),
          navigatorKey: AppConstants.navigationKey,
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case ThemeScreen.routeName:
                    return const ThemeScreen();
                  case BookSearchScreen.routeName:
                    return const BookSearchScreen();
                  case ResultsScreen.routeName:
                    return const ResultsScreen();
                  case SearchHistoryScreen.routeName:
                    return const SearchHistoryScreen();
                  case FavoriteBooksScreen.routeName:
                    return const FavoriteBooksScreen();
                  case BookDetailsScreen.routeName:
                    if (routeSettings.arguments is! Book) {
                      return const BookSearchScreen();
                    }
                    return BookDetailsScreen(
                      book: routeSettings.arguments as Book,
                    );
                  default:
                    return const BookSearchScreen();
                }
              },
            );
          },
        );
      },
    );
  }
}
