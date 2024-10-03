import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/blogary/blogs/providers/blogs_by_search_term_provider.dart';
import 'package:itsula/views/components/animations/empty_contents_with_text_animation_view.dart';
import 'package:itsula/views/components/animations/fof_animation_view.dart';
import 'package:itsula/views/components/animations/shrug_donger_animation_view.dart';
import 'package:itsula/views/components/blog/blog_sliver_grid_view.dart';
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
    final blogs = ref.watch(
      blogsBySearchTermProvider(searchTerm),
    );
    return blogs.when(
      data: (theseBlogs) {
        if (theseBlogs.isEmpty) {
          return const SliverToBoxAdapter(
            child: Center(
              child: ShrugDongerAnimationView(),
            ),
          );
        }
        return BlogSliverGridView(
          blogs: theseBlogs,
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
