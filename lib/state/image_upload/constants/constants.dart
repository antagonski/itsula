import 'package:flutter/foundation.dart' show immutable;

@immutable
class Constants {
  //for photos
  static const imageThumbnailWidth = 150;

  //for videos
  static const videoThumbnailMaxHeight = 400;
  static const videoThumbnailQuality = 75;

  static const defaultImageRelativePath =
      "/Users/leoantagonski/Documents/Flutter/itsula/assets/images/duality_logo_01.png";

  const Constants._();
}
