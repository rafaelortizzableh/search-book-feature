import 'package:hive_flutter/hive_flutter.dart';

import '../../features/book_search/book_search_export.dart';

void registerHiveAdapters() {
  Hive.registerAdapter(ImageLinksAdapter());
  Hive.registerAdapter(BookAdapter());
}
