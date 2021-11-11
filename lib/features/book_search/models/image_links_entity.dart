import '../../../core/core.dart';

class ImageLinksEntity {
  final String? smallThumbnail;
  final String? thumbNail;
  ImageLinksEntity({
    this.smallThumbnail,
    this.thumbNail,
  });

  ImageLinksEntity copyWith({
    String? smallThumbnail,
    String? thumbNail,
  }) {
    return ImageLinksEntity(
      smallThumbnail: smallThumbnail ?? this.smallThumbnail,
      thumbNail: thumbNail ?? this.thumbNail,
    );
  }

  factory ImageLinksEntity.fromMap(Map<String, dynamic> map) {
    return ImageLinksEntity(
      smallThumbnail: map['smallThumbnail'] ?? AppConstants.fallbackBookImage,
      thumbNail: map['thumbnail'] ?? AppConstants.fallbackBookImage,
    );
  }

  factory ImageLinksEntity.fallback() {
    return ImageLinksEntity(
        smallThumbnail: AppConstants.fallbackBookImage,
        thumbNail: AppConstants.fallbackBookImage);
  }

  @override
  String toString() =>
      'ImageLinksEntity(smallThumbnail: $smallThumbnail, thumbNail: $thumbNail)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ImageLinksEntity &&
        other.smallThumbnail == smallThumbnail &&
        other.thumbNail == thumbNail;
  }

  @override
  int get hashCode => smallThumbnail.hashCode ^ thumbNail.hashCode;
}
