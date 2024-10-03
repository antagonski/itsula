import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/constants/firebase_collection_name.dart';
import 'package:itsula/state/constants/firebase_field_name.dart';
import 'package:itsula/state/blogary/blogs/models/blog.dart';
import 'package:itsula/state/blogary/blogs/typedefs/search_term.dart';

final blogsBySearchTermProvider = StreamProvider.family
    .autoDispose<Iterable<Blog>, SearchTerm>((ref, SearchTerm searchTerm) {
  final controller = StreamController<Iterable<Blog>>();

  final sub = FirebaseFirestore.instance
      .collection(
        FirebaseCollectionName.blogs,
      )
      .orderBy(FirebaseFieldName.createdAt, descending: true)
      .snapshots()
      .listen(
    (snapshot) {
      final blogs = snapshot.docs
          .map(
            (doc) => Blog(
              blogId: doc.id,
              json: doc.data(),
            ),
          )
          .where(
            (blog) => blog.message.toLowerCase().contains(
                  searchTerm.toLowerCase(),
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
});
