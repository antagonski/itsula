import 'package:flutter/foundation.dart' show immutable;
import 'package:itsula/enums/date_sorting.dart';
import 'package:itsula/state/blogary/blogs/typedefs/blog_id.dart';

@immutable
class RequestForBlogAndComments {
  final BlogId blogId;
  final bool sortByCreatedAt;
  final DateSorting dateSorting;
  final int? limit;

  const RequestForBlogAndComments({
    required this.blogId,
    this.sortByCreatedAt = true,
    this.dateSorting = DateSorting.newestOnTop,
    this.limit,
  });

  @override
  bool operator ==(covariant RequestForBlogAndComments other) =>
      blogId == other.blogId &&
      sortByCreatedAt == other.sortByCreatedAt &&
      dateSorting == other.dateSorting &&
      limit == other.limit;

  @override
  int get hashCode => Object.hashAll(
        [
          blogId,
          sortByCreatedAt,
          dateSorting,
          limit,
        ],
      );
}
