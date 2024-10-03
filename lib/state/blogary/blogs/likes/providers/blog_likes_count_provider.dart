import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/constants/firebase_collection_name.dart';
import 'package:itsula/state/constants/firebase_field_name.dart';
import 'package:itsula/state/blogary/blogs/typedefs/blog_id.dart';

final blogLikesCountProvider = StreamProvider.family.autoDispose<int, BlogId>(
  (ref, BlogId blogId) {
    final controller = StreamController<int>.broadcast();
    controller.onListen = () {
      controller.sink.add(0);
    };

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.likes)
        .where(FirebaseFieldName.blogId, isEqualTo: blogId)
        .snapshots()
        .listen(
      (snapshot) {
        controller.sink.add(
          snapshot.docs.length,
        );
      },
    );

    ref.onDispose(
      () {
        sub.cancel();
        controller.close();
      },
    );

    return controller.stream;
  },
);
