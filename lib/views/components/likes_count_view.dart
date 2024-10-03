import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/blogary/blogs/likes/providers/blog_likes_count_provider.dart';
import 'package:itsula/state/blogary/blogs/typedefs/blog_id.dart';
import 'package:itsula/views/constants/strings.dart';

class LikeCountView extends ConsumerWidget {
  final BlogId blogId;
  const LikeCountView({required this.blogId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likesCount = ref.watch(
      blogLikesCountProvider(
        blogId,
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
