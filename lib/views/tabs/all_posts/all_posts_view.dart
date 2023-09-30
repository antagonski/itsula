import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/posts/providers/all_posts_provider.dart';
import 'package:itsula/views/components/animations/empty_contents_with_text_animation_view.dart';
import 'package:itsula/views/components/animations/fof_animation_view.dart';
import 'package:itsula/views/components/post/post_grid_view.dart';
import 'package:itsula/views/constants/strings.dart';

class AllPostsView extends ConsumerWidget {
  const AllPostsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(allPostsProvider);
    return RefreshIndicator(
      onRefresh: () {
        ref.refresh(allPostsProvider);
        return Future.delayed(
          const Duration(seconds: 1),
        );
      },
      child: posts.when(
        data: (thesePosts) {
          if (thesePosts.isEmpty) {
            return const EmptyContentsWithTextAnimationView(
              text: Strings.noBlogPostsAvailable,
            );
          } else {
            return PostGridView(posts: thesePosts);
          }
        },
        error: (error, stackTrace) {
          return const Center(
            child: FoFAnimationView(),
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
