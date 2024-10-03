import 'package:itsula/enums/date_sorting.dart';
import 'package:itsula/state/blogary/comments/models/comment.dart';
import 'package:itsula/state/blogary/comments/models/request_for_blog_and_comments.dart';

extension Sorting on Iterable<Comment> {
  Iterable<Comment> applySortingFrom(RequestForBlogAndComments request) {
    if (request.sortByCreatedAt) {
      final sortedDocuments = toList()
        ..sort((a, b) {
          switch (request.dateSorting) {
            case DateSorting.newestOnTop:
              return b.createdAt.compareTo(a.createdAt);
            case DateSorting.oldestOnTop:
              return a.createdAt.compareTo(b.createdAt);
          }
        });
      return sortedDocuments;
    } else {
      return this;
    }
  }
}
