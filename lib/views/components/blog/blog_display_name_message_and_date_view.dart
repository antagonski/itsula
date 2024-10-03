import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/blogary/blogs/models/blog.dart';
import 'package:itsula/state/user_info/providers/user_info_model_provider.dart';
import 'package:itsula/views/components/rich_text_blog_formatted.dart';
import 'package:itsula/views/constants/strings.dart';

class BlogDisplayNameMessageAndDateView extends ConsumerWidget {
  final Blog blog;
  const BlogDisplayNameMessageAndDateView({required this.blog, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfoModel = ref.watch(
      userInfoModelProvider(blog.userId),
    );

    return userInfoModel.when(data: (data) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: RichTextBlogFormatted(
          username: data.displayName,
          content: blog.message,
          date: blog.createdAt,
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
