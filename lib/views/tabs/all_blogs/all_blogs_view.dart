import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/blogary/blogs/providers/all_blogs_provider.dart';
import 'package:itsula/views/components/animations/empty_contents_with_text_animation_view.dart';
import 'package:itsula/views/components/animations/fof_animation_view.dart';
import 'package:itsula/views/components/blog/blog_grid_view.dart';
import 'package:itsula/views/constants/strings.dart';

class AllBlogsView extends ConsumerWidget {
  const AllBlogsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blogs = ref.watch(allBlogsProvider);
    return RefreshIndicator(
      onRefresh: () {
        ref.refresh(allBlogsProvider);
        return Future.delayed(
          const Duration(seconds: 1),
        );
      },
      child: blogs.when(
        data: (theseBlogs) {
          if (theseBlogs.isEmpty) {
            return const EmptyContentsWithTextAnimationView(
              text: Strings.noBlogsAvailable,
            );
          } else {
            return BlogGridView(blogs: theseBlogs);
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
