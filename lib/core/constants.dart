import 'package:flutter/material.dart';

class AppConstants {
  static const String apiKey = String.fromEnvironment('API_KEY');
  static const String googleBooksApi = 'https://www.googleapis.com/books/v1/';
  static const String fallbackBookImage =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f9/Aufgeschlagenes_Buch_--_2020_--_4204.jpg/640px-Aufgeschlagenes_Buch_--_2020_--_4204.jpg';
  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
}
