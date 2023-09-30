import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/comments/models/comment.dart';
import 'package:itsula/state/user_info/providers/user_info_model_provider.dart';
import 'package:itsula/views/components/rich_two_parts_text.dart';
import 'package:itsula/views/constants/strings.dart';

class CompactCommentTile extends ConsumerWidget {
  final Comment comment;
  const CompactCommentTile({required this.comment, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(
      userInfoModelProvider(
        comment.fromUserId,
      ),
    );
    return userInfo.when(data: (userInfoModel) {
      return RichTwoPartsText(
        leftPart: userInfoModel.displayName,
        rightPart: comment.comment,
      );
    }, error: (error, stackTrace) {
      return const Center(
        child: Text(Strings.anErrorHasOccurred),
      );
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
