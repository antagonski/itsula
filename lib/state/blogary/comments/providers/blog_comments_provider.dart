import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/blogary/comments/extensions/comment_sorting_by_request.dart';
import 'package:itsula/state/blogary/comments/models/comment.dart';
import 'package:itsula/state/blogary/comments/models/request_for_blog_and_comments.dart';
import 'package:itsula/state/constants/firebase_collection_name.dart';
import 'package:itsula/state/constants/firebase_field_name.dart';

final blogCommentsProvider = StreamProvider.family
    .autoDispose<Iterable<Comment>, RequestForBlogAndComments>(
        (ref, RequestForBlogAndComments request) {
  final controller = StreamController<Iterable<Comment>>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.comments)
      .where(
        FirebaseFieldName.blogId,
        isEqualTo: request.blogId,
      )
      .snapshots()
      .listen(
    (snapshot) {
      final documents = snapshot.docs;
      final limitedDocs =
          request.limit != null ? documents.take(request.limit!) : documents;
      final comments = limitedDocs
          .where(
            (doc) => !doc.metadata.hasPendingWrites,
          )
          .map(
            (document) => Comment(document.data(), id: document.id),
          );
      final result = comments.applySortingFrom(request);
      return controller.sink.add(result);
    },
  );

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });
  return controller.stream;
});
