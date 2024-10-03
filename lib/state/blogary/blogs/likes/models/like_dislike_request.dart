import 'package:flutter/foundation.dart' show immutable;
import 'package:itsula/state/blogary/blogs/typedefs/blog_id.dart';
import 'package:itsula/state/blogary/blogs/typedefs/user_id.dart';

@immutable
class LikeDislikeRequest {
  final BlogId blogId;
  final UserId likedBy;

  const LikeDislikeRequest({
    required this.blogId,
    required this.likedBy,
  });
}
