import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/posts/providers/user_posts_provider.dart';
import 'package:itsula/views/components/animations/empty_contents_with_text_animation_view.dart';
import 'package:itsula/views/components/animations/fof_animation_view.dart';
import 'package:itsula/views/components/animations/jumping_slime_animation_view.dart';
import 'package:itsula/views/components/post/post_grid_view.dart';
import 'package:itsula/views/constants/strings.dart';

class UserPostsView extends ConsumerWidget {
  const UserPostsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(userPostsProvider);
    return RefreshIndicator(
      onRefresh: () {
        ref.refresh(userPostsProvider);
        return Future.delayed(
          const Duration(seconds: 1),
        );
      },
      child: posts.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const EmptyContentsWithTextAnimationView(
              text: Strings.youHaveNoBlogPostsYet,
            );
          } else {
            return PostGridView(posts: posts);
          }
        },
        error: (error, stackTrace) {
          if (kDebugMode) {
            print("Erorr UPV");
          }
          return const FoFAnimationView();
        },
        loading: () {
          if (kDebugMode) {
            print("Loading UPV");
          }
          return const JumpingSlimeAnimationView();
        },
      ),
    );
  }
}
