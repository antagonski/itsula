import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/blogary/comments/extensions/comment_sorting_by_request.dart';
import 'package:itsula/state/blogary/comments/models/comment.dart';
import 'package:itsula/state/blogary/comments/models/blog_with_comments.dart';
import 'package:itsula/state/blogary/comments/models/request_for_blog_and_comments.dart';
import 'package:itsula/state/constants/firebase_collection_name.dart';
import 'package:itsula/state/constants/firebase_field_name.dart';
import 'package:itsula/state/blogary/blogs/models/blog.dart';

final specificBlogWithCommentsProvider = StreamProvider.family
    .autoDispose<BlogWithComments, RequestForBlogAndComments>(
  (
    ref,
    RequestForBlogAndComments request,
  ) {
    final controller = StreamController<BlogWithComments>();
    Blog? blog;
    Iterable<Comment>? comments;

    void notify() {
      final localBlog = blog;
      if (localBlog == null) {
        return;
      }
      final localComments = (comments ?? []).applySortingFrom(
        request,
      );
      final result = BlogWithComments(
        blog: localBlog,
        comments: localComments,
      );
      controller.sink.add(
        result,
      );
    }

    final blogSub = FirebaseFirestore.instance
        .collection(
          FirebaseCollectionName.blogs,
        )
        .where(
          FieldPath.documentId,
          isEqualTo: request.blogId,
        )
        .limit(1)
        .snapshots()
        .listen(
      (snapshot) {
        if (snapshot.docs.isEmpty) {
          blog = null;
          comments = null;
          notify();
          return;
        }
        final doc = snapshot.docs.first;
        if (doc.metadata.hasPendingWrites) {
          return;
        }
        blog = Blog(
          blogId: doc.id,
          json: doc.data(),
        );
        notify();
      },
    );

    final commentsQuery = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.comments)
        .where(
          FirebaseFieldName.blogId,
          isEqualTo: request.blogId,
        )
        .orderBy(
          FirebaseFieldName.createdAt,
          descending: true,
        );
    final limitedCommentsQuery = request.limit != null
        ? commentsQuery.limit(request.limit!)
        : commentsQuery;

    final commentsSub = limitedCommentsQuery.snapshots().listen(
      (snapshots) {
        comments = snapshots.docs
            .where((doc) => !doc.metadata.hasPendingWrites)
            .map(
              (doc) => Comment(
                doc.data(),
                id: doc.id,
              ),
            )
            .toList();
        notify();
      },
    );

    ref.onDispose(() {
      commentsSub.cancel();
      blogSub.cancel();
      controller.close();
    });
    return controller.stream;
  },
);
