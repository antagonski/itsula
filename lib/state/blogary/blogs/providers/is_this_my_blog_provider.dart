import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/auth/providers/user_id_provider.dart';
import 'package:itsula/state/blogary/blogs/models/blog.dart';

final isThisMyBlogProvider = StreamProvider.family.autoDispose<bool, Blog>(
  (
    ref,
    Blog blog,
  ) async* {
    final userId = ref.watch(userIdProvider);
    yield userId == blog.userId;
  },
);
