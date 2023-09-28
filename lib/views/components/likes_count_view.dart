import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/likes/providers/post_likes_count_provider.dart';
import 'package:itsula/state/posts/typedefs/post_id.dart';
import 'package:itsula/views/constants/strings.dart';

class LikeCountView extends ConsumerWidget {
  final PostId postId;
  const LikeCountView({required this.postId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likesCount = ref.watch(
      postLikesCountProvider(
        postId,
      ),
    );
    return likesCount.when(data: (int likesCount) {
      final personOrPeople = likesCount == 1 ? Strings.person : Strings.people;
      final likesText = '$likesCount $personOrPeople ${Strings.likedThis}';
      return Text(
        likesText,
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
