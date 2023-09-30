import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/posts/providers/posts_by_search_term_provider.dart';
import 'package:itsula/views/components/animations/empty_contents_with_text_animation_view.dart';
import 'package:itsula/views/components/animations/fof_animation_view.dart';
import 'package:itsula/views/components/animations/shrug_donger_animation_view.dart';
import 'package:itsula/views/components/post/post_sliver_grid_view.dart';
import 'package:itsula/views/constants/strings.dart';

class SearchGridView extends ConsumerWidget {
  final String searchTerm;
  const SearchGridView({required this.searchTerm, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (searchTerm.isEmpty) {
      return const SliverToBoxAdapter(
        child: EmptyContentsWithTextAnimationView(
            text: Strings.enterYourSearchTerm),
      );
    }
    final posts = ref.watch(
      postsBySearchTermProvider(searchTerm),
    );
    return posts.when(
      data: (posts) {
        if (posts.isEmpty) {
          return const SliverToBoxAdapter(
            child: Center(
              child: ShrugDongerAnimationView(),
            ),
          );
        }
        return PostSliverGridView(
          posts: posts,
        );
      },
      error: (error, stackTrace) {
        return const SliverToBoxAdapter(
          child: Center(
            child: FoFAnimationView(),
          ),
        );
      },
      loading: () {
        return const SliverToBoxAdapter(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
