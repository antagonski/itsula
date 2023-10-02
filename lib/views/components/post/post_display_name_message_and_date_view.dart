import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/posts/models/post.dart';
import 'package:itsula/state/user_info/providers/user_info_model_provider.dart';
import 'package:itsula/views/components/rich_text_post_formatted.dart';
import 'package:itsula/views/constants/strings.dart';

class PostDisplayNameMessageAndDateView extends ConsumerWidget {
  final Post post;
  const PostDisplayNameMessageAndDateView({required this.post, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfoModel = ref.watch(
      userInfoModelProvider(post.userId),
    );

    return userInfoModel.when(data: (data) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: RichTextPostFormatted(
          username: data.displayName,
          content: post.message,
          date: post.createdAt,
        ),
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
