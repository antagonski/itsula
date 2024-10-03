import 'dart:collection' show MapView;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:itsula/state/constants/firebase_field_name.dart';
import 'package:itsula/state/blogary/blogs/typedefs/blog_id.dart';
import 'package:itsula/state/blogary/blogs/typedefs/user_id.dart';

@immutable
class CommentPayload extends MapView<String, dynamic> {
  CommentPayload({
    required UserId fromUserId,
    required BlogId onBlogId,
    required String comment,
  }) : super({
          FirebaseFieldName.userId: fromUserId,
          FirebaseFieldName.blogId: onBlogId,
          FirebaseFieldName.createdAt: FieldValue.serverTimestamp(),
          FirebaseFieldName.comment: comment,
        });
}
