import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/auth/providers/user_id_provider.dart';
import 'package:itsula/state/constants/firebase_collection_name.dart';
import 'package:itsula/state/constants/firebase_field_name.dart';
import 'package:itsula/state/blogary/blogs/typedefs/blog_id.dart';

final hasLikedBlogProvider = StreamProvider.family.autoDispose<bool, BlogId>(
  (ref, BlogId blogId) {
    final userId = ref.watch(userIdProvider);
    if (userId == null) {
      return Stream<bool>.value(false);
    }

    final controller = StreamController<bool>();
    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.likes)
        .where(
          FirebaseFieldName.blogId,
          isEqualTo: blogId,
        )
        .where(
          FirebaseFieldName.userId,
          isEqualTo: userId,
        )
        .snapshots()
        .listen(
      (snapshot) {
        if (snapshot.docs.isNotEmpty) {
          controller.add(true);
        } else {
          controller.add(false);
        }
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
