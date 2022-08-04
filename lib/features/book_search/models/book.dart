import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../book_search_export.dart';

part 'book.g.dart';

@HiveType(typeId: 1)
class Book extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String id;
  @HiveField(2)
  final List<String> authors;
  @HiveField(3)
  final String publishedDateString;
  @HiveField(4)
  final String description;
  @HiveField(5)
  final int pageCount;
  @HiveField(6)
  final ImageLinks imageLinks;
  @HiveField(7)
  final String timeStamp;

  Book({
    required this.title,
    required this.id,
    required this.authors,
    required this.publishedDateString,
    required this.description,
    required this.pageCount,
    required this.imageLinks,
    required this.timeStamp,
  });

  factory Book.fromEntity(BookRemoteEntity entity) {
    return Book(
      id: entity.id,
      title: entity.title ?? '',
      authors: entity.authors ?? [],
      publishedDateString: entity.publishedDateString ?? '',
      description: entity.description ?? '',
      pageCount: entity.pageCount ?? 0,
      timeStamp: DateTime.now().toString(),
      imageLinks: ImageLinks.fromEntity(
          entity.imageLinksEntity ?? ImageLinksEntity.fallback()),
    );
  }

  @override
  String toString() {
    return 'Book(title: $title, authors: $authors, publishedDateString: $publishedDateString, description: $description, pageCount: $pageCount, imageLinks: $imageLinks)';
  }

  Book copyWith({
    String? title,
    List<String>? authors,
    String? publishedDateString,
    String? description,
    int? pageCount,
    ImageLinks? imageLinks,
    String? timeStamp,
  }) {
    return Book(
      timeStamp: timeStamp ?? this.timeStamp,
      id: id,
      title: title ?? this.title,
      authors: authors ?? this.authors,
      publishedDateString: publishedDateString ?? this.publishedDateString,
      description: description ?? this.description,
      pageCount: pageCount ?? this.pageCount,
      imageLinks: imageLinks ?? this.imageLinks,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Book &&
        other.title == title &&
        other.timeStamp == timeStamp &&
        other.id == id &&
        listEquals(other.authors, authors) &&
        other.publishedDateString == publishedDateString &&
        other.description == description &&
        other.pageCount == pageCount &&
        other.imageLinks == imageLinks;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        id.hashCode ^
        authors.hashCode ^
        publishedDateString.hashCode ^
        description.hashCode ^
        pageCount.hashCode ^
        timeStamp.hashCode ^
        imageLinks.hashCode;
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
      'authors': authors,
      'publishedDateString': publishedDateString,
      'description': description,
      'pageCount': pageCount,
      'imageLinks': imageLinks.toMap(),
      'timeStamp': timeStamp,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      title: map['title'] ?? '',
      id: map['id'] ?? '',
      authors: List<String>.from(map['authors']),
      publishedDateString: map['publishedDateString'] ?? '',
      description: map['description'] ?? '',
      pageCount: map['pageCount']?.toInt() ?? 0,
      imageLinks: ImageLinks.fromMap(map['imageLinks']),
      timeStamp: map['timeStamp'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) => Book.fromMap(json.decode(source));

  bool isFavorite(List<Book> favorites) {
    return favorites.map((favoriteBook) => favoriteBook.id).contains(id);
  }
}
