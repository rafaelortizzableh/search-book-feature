import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme_export.dart';

/// Provider of [ThemeService]
final themeServiceProvider = Provider<ThemeService>(
  (ref) => ThemeService(
    ref.read,
  ),
);

/// State Notifier Provider of [ThemeController]
final themeControllerProvider =
    StateNotifierProvider<ThemeController, ThemeMode>(
        (ref) => ThemeController(ref.watch(themeServiceProvider)));
