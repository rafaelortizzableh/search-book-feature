import 'package:shared_preferences/shared_preferences.dart';

// class SharedPreferencesService {
//   final SharedPreferences prefs;

//   SharedPreferencesService(this.prefs);

//   String? get getUserTheme => prefs.getString('selectedTheme');

//   Future<bool> setPreferredTheme(String theme) async {
//     try {
//       return await prefs.setString('selectedTheme', theme);
//     } catch (e) {
//       debugPrint(e.toString());
//       rethrow;
//     }
//   }

//   List<String>? get getPreviousSearches =>
//       prefs.getStringList('previousSearches');

//   Future<bool> addUserSearch(String search) async {
//     try {
//       final userSearches = prefs.getStringList('previousSearches') ?? [];
//       final newList = [...userSearches, search];
//       return await prefs.setStringList(
//           'previousSearches', newList.toSet().toList());
//     } catch (e) {
//       debugPrint(e.toString());
//       rethrow;
//     }
//   }

//   Future<bool> removeUserSearch(String search) async {
//     try {
//       final userSearches = prefs.getStringList('previousSearches') ?? [];
//       if (userSearches.contains(search)) {
//         userSearches.remove(search);
//       }
//       return await prefs.setStringList(
//           'previousSearches', userSearches.toSet().toList());
//     } catch (e) {
//       debugPrint(e.toString());
//       rethrow;
//     }
//   }

//   List<String>? get getFavoriteBooks => prefs.getStringList('favoriteBooks');

//   Future<bool> addFavoriteBook(String bookId) async {
//     try {
//       final favoriteBooks = prefs.getStringList('favoriteBooks') ?? [];
//       final newList = [...favoriteBooks, bookId];
//       return await prefs.setStringList(
//           'favoriteBooks', newList.toSet().toList());
//     } catch (e) {
//       debugPrint(e.toString());
//       rethrow;
//     }
//   }

//   Future<bool> removeFavoriteBook(String bookId) async {
//     try {
//       final favoriteBooks = prefs.getStringList('favoriteBooks') ?? [];
//       if (favoriteBooks.contains(bookId)) {
//         favoriteBooks.remove(bookId);
//       }
//       return await prefs.setStringList(
//           'favoriteBooks', favoriteBooks.toSet().toList());
//     } catch (e) {
//       debugPrint(e.toString());
//       rethrow;
//     }
//   }

// }

class SharedPreferencesService {
  final SharedPreferences _sharedPreferences;

  SharedPreferencesService(this._sharedPreferences);

  /// Fetch a string from Local Storage ([SharedPreferences]).
  ///
  /// If you're getting an object don't forget to convert it with a fromJson method.
  String? getStringFromSharedPreferences(String key) {
    return _sharedPreferences.getString(key);
  }

  /// Fetch a list of strings from Local Storage ([SharedPreferences]).
  List<String>? getListOfStringsFromSharedPreferences(String key) {
    return _sharedPreferences.getStringList(key);
  }

  /// Fetch a bool from Local Storage ([SharedPreferences]).
  bool? getBoolFromSharedPreferences(String key) {
    return _sharedPreferences.getBool(key);
  }

  /// Fetch an int from Local Storage ([SharedPreferences]).
  int? getIntFromSharedPreferences(String key) {
    return _sharedPreferences.getInt(key);
  }

  /// Fetch a double from Local Storage ([SharedPreferences]).
  double? getDoubleFromSharedPreferences(String key) {
    return _sharedPreferences.getDouble(key);
  }

  /// Fetch a double from Local Storage ([SharedPreferences]).
  Future<bool> saveListOfStringsToSharedPreferences(
      String key, List<String> values) async {
    return await _sharedPreferences.setStringList(key, values);
  }

  /// Content can be either a string, bool, int or double.
  ///
  /// If you want to save a different type, try saving it with a toJSon method.
  /// To save a list of type string, call `saveListOfStringsToSharedPreferences`
  Future<bool> saveToSharedPreferences<T>(String key, T value) async {
    assert(
      value.runtimeType != List<String>,
      'Don\'t call this method with List<String>. Instead, call `saveListOfStringsToSharedPreferences`',
    );
    switch (value.runtimeType) {
      case String:
        return await _sharedPreferences.setString(key, value as String);
      case bool:
        return await _sharedPreferences.setBool(key, value as bool);
      case int:
        return await _sharedPreferences.setInt(key, value as int);
      case double:
        return await _sharedPreferences.setDouble(key, value as double);
      default:
        throw Exception(
            'Can\'t save content of type ${value.runtimeType}. Content should of types String, bool, int, double or List<String>. Try passing the object as a JSON encoded String with a toJson method');
    }
  }
}
