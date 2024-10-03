import 'dart:collection' show MapView;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:itsula/state/image_upload/models/file_type.dart';
import 'package:itsula/state/blog_settings/models/blog_setting.dart';
import 'package:itsula/state/blogary/blogs/models/blog_key.dart';
import 'package:itsula/state/blogary/blogs/typedefs/user_id.dart';

@immutable
class BlogPayload extends MapView<String, dynamic> {
  BlogPayload({
    required UserId userId,
    required String message,
    required String thumbnailUrl,
    required String fileUrl,
    required FileType fileType,
    required String fileName,
    required double aspectRatio,
    required String thumbnailStorageId,
    required String originalFileStorageId,
    required Map<BlogSetting, bool> blogSettings,
  }) : super({
          BlogKey.userId: userId,
          BlogKey.message: message,
          BlogKey.createdAt: FieldValue.serverTimestamp(),
          BlogKey.thumbnailUrl: thumbnailUrl,
          BlogKey.fileUrl: fileUrl,
          BlogKey.fileType: fileType.name,
          BlogKey.fileName: fileName,
          BlogKey.aspectRatio: aspectRatio,
          BlogKey.thumbnailStorageId: thumbnailStorageId,
          BlogKey.originalFileStorageId: originalFileStorageId,
          BlogKey.blogSettings: {
            for (final blogSetting in blogSettings.entries)
              blogSetting.key.storageKey: blogSetting.value,
          },
        });
}
