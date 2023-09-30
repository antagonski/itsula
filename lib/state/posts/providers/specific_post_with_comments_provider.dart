import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/comments/extensions/comment_sorting_by_request.dart';
import 'package:itsula/state/comments/models/comment.dart';
import 'package:itsula/state/comments/models/post_with_comments.dart';
import 'package:itsula/state/comments/models/request_for_post_and_comments.dart';
import 'package:itsula/state/constants/firebase_collection_name.dart';
import 'package:itsula/state/constants/firebase_field_name.dart';
import 'package:itsula/state/posts/models/post.dart';

final specificPostWithCommentsProvider = StreamProvider.family
    .autoDispose<PostWithComments, RequestForPostAndComments>(
  (
    ref,
    RequestForPostAndComments request,
  ) {
    final controller = StreamController<PostWithComments>();
    Post? post;
    Iterable<Comment>? comments;

    void notify() {
      if (kDebugMode) {
        print('starting notify function');
      }
      final localPost = post;
      if (localPost == null) {
        if (kDebugMode) {
          print('local post is null, returning.');
        }
        return;
      }
      final localComments = (comments ?? []).applySortingFrom(
        request,
      );
      final result = PostWithComments(
        post: localPost,
        comments: localComments,
      );
      controller.sink.add(
        result,
      );
    }

    final postSub = FirebaseFirestore.instance
        .collection(
          FirebaseCollectionName.posts,
        )
        .where(
          FieldPath.documentId,
          isEqualTo: request.postId,
        )
        .limit(1)
        .snapshots()
        .listen(
      (snapshot) {
        if (snapshot.docs.isEmpty) {
          post = null;
          comments = null;
          notify();
          return;
        }
        final doc = snapshot.docs.first;
        if (doc.metadata.hasPendingWrites) {
          return;
        }
        post = Post(
          postId: doc.id,
          json: doc.data(),
        );
        notify();
      },
    );

    final commentsQuery = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.comments)
        .where(
          FirebaseFieldName.postId,
          isEqualTo: request.postId,
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
      postSub.cancel();
      controller.close();
    });
    return controller.stream;
  },
);
