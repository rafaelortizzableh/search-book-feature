import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/core.dart';

class ThemeService {
  final Reader _read;
  ThemeService(this._read);

  /// Loads the User's preferred ThemeMode from local or remote storage.
  ThemeMode themeMode() {
    final prefs = _read(sharedPreferencesServiceProvider);
    switch (prefs.getStringFromSharedPreferences('selectedTheme')) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<bool> updateThemeMode(ThemeMode theme) async {
    final prefs = _read(sharedPreferencesServiceProvider);
    switch (theme) {
      case ThemeMode.light:
        return await prefs.saveToSharedPreferences('selectedTheme', 'light');
      case ThemeMode.dark:
        return await prefs.saveToSharedPreferences('selectedTheme', 'dark');

      case ThemeMode.system:
        return await prefs.saveToSharedPreferences('selectedTheme', 'system');
    }
  }
}
