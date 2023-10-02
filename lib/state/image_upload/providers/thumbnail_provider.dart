import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/image_upload/exceptions/could_not_build_thumbnail_exception.dart';
import 'package:itsula/state/image_upload/extensions/get_image_aspect_ratio.dart';
import 'package:itsula/state/image_upload/models/file_type.dart';
import 'package:itsula/state/image_upload/models/image_with_aspect_ratio.dart';
import 'package:itsula/state/image_upload/models/thumbnail_request.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

final thumbnailProvider =
    FutureProvider.family.autoDispose<ImageWithAspectRatio, ThumbnailRequest>(
  (ref, ThumbnailRequest request) async {
    if (kDebugMode) {
      print('entered thumbnail request');
    }
    final Image image;
    switch (request.fileType) {
      case FileType.image:
        image = Image.file(
          request.file,
          fit: BoxFit.fitHeight,
        );

        break;
      case FileType.video:
        final thumbnail = await VideoThumbnail.thumbnailData(
          video: request.file.path,
          imageFormat: ImageFormat.JPEG,
          quality: 75,
        );
        if (thumbnail == null) {
          throw const CouldNotBuildThumbnailException();
        } else {
          image = Image.memory(
            thumbnail,
            fit: BoxFit.fitHeight,
          );
        }
        break;
    }
    if (kDebugMode) {
      print("thumbnail provider got the file");
    }
    final aspectRatio = await image.getAspectRatio();
    if (kDebugMode) {
      print("thumbnail provider got the aspect ratio");
    }
    return ImageWithAspectRatio(image: image, aspectRatio: aspectRatio);
  },
);
