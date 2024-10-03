import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/image_upload/typedefs/is_loading.dart';
import 'package:itsula/state/blogary/blogs/notifiers/delete_blog_state_notifier.dart';

final deleteBlogProvider =
    StateNotifierProvider<DeleteBlogStateNotifier, IsLoading>(
  (_) => DeleteBlogStateNotifier(),
);
