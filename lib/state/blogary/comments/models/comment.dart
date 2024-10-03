import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:itsula/state/blogary/comments/typedefs/comment_id.dart';
import 'package:itsula/state/constants/firebase_field_name.dart';
import 'package:itsula/state/blogary/blogs/typedefs/blog_id.dart';
import 'package:itsula/state/blogary/blogs/typedefs/user_id.dart';

@immutable
class Comment {
  final CommentId id;
  final String comment;
  final DateTime createdAt;
  final UserId fromUserId;
  final BlogId onBlogId;

  Comment(Map<String, dynamic> json, {required this.id})
      : comment = json[FirebaseFieldName.comment],
        createdAt = (json[FirebaseFieldName.createdAt] as Timestamp).toDate(),
        fromUserId = json[FirebaseFieldName.userId],
        onBlogId = json[FirebaseFieldName.blogId];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Comment &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          comment == other.comment &&
          createdAt == other.createdAt &&
          fromUserId == other.fromUserId &&
          onBlogId == other.onBlogId;
  @override
  int get hashCode => Object.hashAll(
        [
          id,
          comment,
          createdAt,
          fromUserId,
          onBlogId,
        ],
      );
}
