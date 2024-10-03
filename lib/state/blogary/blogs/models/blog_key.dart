import 'package:flutter/foundation.dart' show immutable;

@immutable
class BlogKey {
  static const userId = 'uid';
  static const message = 'message';
  static const createdAt = 'created_at';
  static const thumbnailUrl = 'thumbnail_url';
  static const fileUrl = 'file_url';
  static const fileType = 'file_type';
  static const fileName = 'file_name';
  static const aspectRatio = 'aspect_ratio';
  static const blogSettings = 'blog_settings';
  static const thumbnailStorageId = 'thumbnail_storage_id';
  static const originalFileStorageId = 'original_file_storage_id';

  const BlogKey._();
}
