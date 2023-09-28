import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/comments/extensions/comment_sorting_by_request.dart';
import 'package:itsula/state/comments/models/comment.dart';
import 'package:itsula/state/comments/models/request_for_post_and_comments.dart';
import 'package:itsula/state/constants/firebase_collection_name.dart';
import 'package:itsula/state/constants/firebase_field_name.dart';

final postCommentsProvider = StreamProvider.family
    .autoDispose<Iterable<Comment>, RequestForPostAndComments>(
        (ref, RequestForPostAndComments request) {
  final controller = StreamController<Iterable<Comment>>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectiondName.comments)
      .where(
        FirebaseFieldName.postId,
        isEqualTo: request.postId,
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
