import 'dart:collection' show MapView;

import 'package:flutter/foundation.dart' show immutable;
import 'package:itsula/state/constants/firebase_field_name.dart';
import 'package:itsula/state/blogary/blogs/typedefs/blog_id.dart';
import 'package:itsula/state/blogary/blogs/typedefs/user_id.dart';

@immutable
class Like extends MapView<String, String> {
  Like({
    required BlogId blogId,
    required UserId likedBy,
    required DateTime date,
  }) : super({
          FirebaseFieldName.blogId: blogId,
          FirebaseFieldName.userId: likedBy,
          FirebaseFieldName.date: date.toIso8601String(),
        });
}
