import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/comments/notifiers/delete_comment_notifier.dart';

final deleteCommentProvider =
    StateNotifierProvider<DeleteCommentStateNotifier, bool>(
  (_) => DeleteCommentStateNotifier(),
);
