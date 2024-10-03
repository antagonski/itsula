import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/auth/providers/auth_state_provider.dart';
import 'package:itsula/state/blogary/comments/providers/delete_comment_provider.dart';
import 'package:itsula/state/blogary/comments/providers/send_comment_provider.dart';
import 'package:itsula/state/image_upload/providers/image_upload_provider.dart';
import 'package:itsula/state/blogary/blogs/providers/delete_blog_provider.dart';

final isLoadingProvider = Provider<bool>(
  (ref) {
    final authState = ref.watch(authStateProvider);
    final isUploadingImage = ref.watch(imageUploadProvider);
    final isSendingComment = ref.watch(sendCommentProvider);
    final isDeletingComment = ref.watch(deleteCommentProvider);
    final isDeletingBlog = ref.watch(deleteBlogProvider);

    return authState.isLoading ||
        isUploadingImage ||
        isSendingComment ||
        isDeletingComment ||
        isDeletingBlog;
  },
);
