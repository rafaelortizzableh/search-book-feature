import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/core.dart';
import '../book_search_export.dart';

part 'image_links.g.dart';

@HiveType(typeId: 0)
class ImageLinks extends HiveObject {
  @HiveField(0)
  final String smallThumbnail;
  @HiveField(1)
  final String thumbNail;

  ImageLinks({
    required this.smallThumbnail,
    required this.thumbNail,
  });

  ImageLinks copyWith({
    String? smallThumbnail,
    String? thumbNail,
  }) {
    return ImageLinks(
      smallThumbnail: smallThumbnail ?? this.smallThumbnail,
      thumbNail: thumbNail ?? this.thumbNail,
    );
  }

  factory ImageLinks.fromMap(Map<String, dynamic> map) {
    return ImageLinks(
      smallThumbnail: map['smallThumbnail'] ?? '',
      thumbNail: map['thumbNail'] ?? '',
    );
  }

  factory ImageLinks.fromEntity(ImageLinksEntity entity) {
    return ImageLinks(
      smallThumbnail: entity.smallThumbnail ?? AppConstants.fallbackBookImage,
      thumbNail: entity.thumbNail ?? AppConstants.fallbackBookImage,
    );
  }

  @override
  String toString() =>
      'ImageLinks(smallThumbnail: $smallThumbnail, thumbNail: $thumbNail)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ImageLinks &&
        other.smallThumbnail == smallThumbnail &&
        other.thumbNail == thumbNail;
  }

  @override
  int get hashCode => smallThumbnail.hashCode ^ thumbNail.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'smallThumbnail': smallThumbnail,
      'thumbNail': thumbNail,
    };
  }

  String toJson() => json.encode(toMap());

  factory ImageLinks.fromJson(String source) =>
      ImageLinks.fromMap(json.decode(source));
}
