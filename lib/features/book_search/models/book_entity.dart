import '../book_search_export.dart';

class BookRemoteEntity {
  final String? title;
  final String id;
  final List<String>? authors;
  final String? publishedDateString;
  final String? description;
  final int? pageCount;
  final ImageLinksEntity? imageLinksEntity;

  BookRemoteEntity({
    required this.id,
    required this.title,
    required this.authors,
    required this.publishedDateString,
    required this.description,
    required this.pageCount,
    required this.imageLinksEntity,
  });

  factory BookRemoteEntity.fromMapAndId(Map<String, dynamic> map, String id) {
    return BookRemoteEntity(
      id: id,
      title: map['title'],
      authors: map['authors'] != null ? List<String>.from(map['authors']) : [],
      publishedDateString: map['publishedDate'] ?? '',
      description: map['description'] ?? '',
      pageCount: map['pageCount'] ?? 0,
      imageLinksEntity: map['imageLinks'] != null
          ? ImageLinksEntity.fromMap(map['imageLinks'])
          : ImageLinksEntity.fallback(),
    );
  }

  @override
  String toString() {
    return 'BookEntity(id: $id, title: $title, authors: $authors, publishedDateString: $publishedDateString, description: $description, pageCount: $pageCount, imageLinksEntity: $imageLinksEntity)';
  }
}
