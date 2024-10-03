import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:itsula/state/blogary/comments/models/comment.dart';
import 'package:itsula/state/blogary/blogs/models/blog.dart';

@immutable
class BlogWithComments {
  final Blog blog;
  final Iterable<Comment> comments;

  const BlogWithComments({
    required this.blog,
    required this.comments,
  });

  @override
  bool operator ==(covariant BlogWithComments other) =>
      blog == other.blog &&
      const IterableEquality().equals(
        comments,
        other.comments,
      );

  @override
  int get hashCode => Object.hashAll(
        [
          blog,
          comments,
        ],
      );
}
