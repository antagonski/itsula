import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/constants/firebase_collection_name.dart';
import 'package:itsula/state/constants/firebase_field_name.dart';
import 'package:itsula/state/blogary/blogs/models/blog.dart';

final allBlogsProvider = StreamProvider.autoDispose<Iterable<Blog>>(
  (ref) {
    final controller = StreamController<Iterable<Blog>>();

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.blogs)
        .orderBy(FirebaseFieldName.createdAt, descending: true)
        .snapshots()
        .listen(
      (snapshosts) {
        final blogs = snapshosts.docs.map(
          (doc) => Blog(
            blogId: doc.id,
            json: doc.data(),
          ),
        );
        controller.sink.add(blogs);
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
