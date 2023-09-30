import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/auth/providers/user_id_provider.dart';
import 'package:itsula/state/comments/models/comment.dart';
import 'package:itsula/state/comments/providers/delete_comment_provider.dart';
import 'package:itsula/state/user_info/providers/user_info_model_provider.dart';
import 'package:itsula/views/components/animations/fof_animation_view.dart';
import 'package:itsula/views/components/dialogs/alert_dialog_model.dart';
import 'package:itsula/views/components/dialogs/delete_dialog.dart';
import 'package:itsula/views/constants/strings.dart';

class CommentTile extends ConsumerWidget {
  final Comment comment;
  const CommentTile({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(
      userInfoModelProvider(comment.fromUserId),
    );
    return userInfo.when(data: (userInfoModel) {
      final currentUserId = ref.read(userIdProvider);
      return ListTile(
        trailing: currentUserId == comment.fromUserId
            ? IconButton(
                onPressed: () async {
                  final shouldDeleteComment = await displayDeleteDialog(
                    context,
                  );
                  if (shouldDeleteComment) {
                    await ref
                        .read(deleteCommentProvider.notifier)
                        .deleteComment(commentId: comment.id);
                  }
                },
                icon: const Icon(
                  Icons.delete_outline_outlined,
                ),
              )
            : null,
        title: Text(
          userInfoModel.displayName,
        ),
        subtitle: Text(
          comment.comment,
        ),
      );
    }, error: (error, stackTrace) {
      return const FoFAnimationView();
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }

  Future<bool> displayDeleteDialog(BuildContext context) =>
      const DeleteDialog(titleOfObjectToDelete: Strings.comment)
          .present(context)
          .then(
            (value) => value ?? false,
          );
}
