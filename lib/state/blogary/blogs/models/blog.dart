import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:itsula/state/image_upload/models/file_type.dart';
import 'package:itsula/state/blog_settings/models/blog_setting.dart';
import 'package:itsula/state/blogary/blogs/models/blog_key.dart';

@immutable
class Blog {
  final String blogId;
  final String userId;
  final String message;
  final DateTime createdAt;
  final String thumbnailUrl;
  final String fileUrl;
  final FileType fileType;
  final String fileName;
  final double aspectRatio;
  final String thumbnailStorageId;
  final String originalFileStorageId;
  final Map<BlogSetting, bool> blogSettings;

  Blog({required this.blogId, required Map<String, dynamic> json})
      : userId = json[BlogKey.userId],
        message = json[BlogKey.message],
        createdAt = (json[BlogKey.createdAt] as Timestamp).toDate(),
        thumbnailUrl = json[BlogKey.thumbnailUrl],
        fileUrl = json[BlogKey.fileUrl],
        fileType = FileType.values.firstWhere(
          (fileType) => fileType.name == json[BlogKey.fileType],
          orElse: () => FileType.image,
        ),
        fileName = json[BlogKey.fileName],
        aspectRatio = json[BlogKey.aspectRatio],
        thumbnailStorageId = json[BlogKey.thumbnailStorageId],
        originalFileStorageId = json[BlogKey.originalFileStorageId],
        blogSettings = {
          for (final entry in json[BlogKey.blogSettings].entries)
            BlogSetting.values
                    .firstWhere((element) => element.storageKey == entry.key):
                entry.value,
        };

  bool get allowLikes => blogSettings[BlogSetting.allowLikes] ?? false;
  bool get allowComments => blogSettings[BlogSetting.allowComments] ?? false;
}
