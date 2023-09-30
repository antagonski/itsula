import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:itsula/state/comments/models/comment.dart';
import 'package:itsula/state/posts/models/post.dart';

@immutable
class PostWithComments {
  final Post post;
  final Iterable<Comment> comments;

  const PostWithComments({
    required this.post,
    required this.comments,
  });

  @override
  bool operator ==(covariant PostWithComments other) =>
      post == other.post &&
      const IterableEquality().equals(
        comments,
        other.comments,
      );

  @override
  int get hashCode => Object.hashAll(
        [
          post,
          comments,
        ],
      );
}
