import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/comments/notifiers/send_comment_notifier.dart';
import 'package:itsula/state/image_upload/typedefs/is_loading.dart';

final sendCommentProvider =
    StateNotifierProvider<SendCommentNotifier, isLoading>(
  (_) => SendCommentNotifier(),
);
