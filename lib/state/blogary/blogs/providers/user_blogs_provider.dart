import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/auth/providers/user_id_provider.dart';
import 'package:itsula/state/constants/firebase_collection_name.dart';
import 'package:itsula/state/constants/firebase_field_name.dart';
import 'package:itsula/state/blogary/blogs/models/blog.dart';
import 'package:itsula/state/blogary/blogs/models/blog_key.dart';

final userBlogsProvider = StreamProvider.autoDispose<Iterable<Blog>>(
  (ref) {
    final userId = ref.watch(userIdProvider);
    final controller = StreamController<Iterable<Blog>>();

    controller.onListen = () {
      controller.sink.add([]);
    };

    final sub = FirebaseFirestore.instance
        .collection(
          FirebaseCollectionName.blogs,
        )
        .orderBy(
          FirebaseFieldName.createdAt,
          descending: true,
        )
        .where(
          BlogKey.userId,
          isEqualTo: userId,
        )
        .snapshots()
        .listen(
      (snapshot) {
        final documents = snapshot.docs;
        final blogs = documents
            .where(
              (document) => !document.metadata.hasPendingWrites,
            )
            .map(
              (document) => Blog(
                blogId: document.id,
                json: document.data(),
              ),
            );
        controller.sink.add(blogs);
      },
    );

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
