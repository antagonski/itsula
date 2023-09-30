import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/auth/providers/user_id_provider.dart';
import 'package:itsula/state/posts/models/post.dart';

final isThisMyPostProvider = StreamProvider.family.autoDispose<bool, Post>(
  (
    ref,
    Post post,
  ) async* {
    final userId = ref.watch(userIdProvider);
    yield userId == post.userId;
  },
);
