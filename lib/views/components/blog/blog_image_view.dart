import 'package:flutter/material.dart';
import 'package:itsula/state/blogary/blogs/models/blog.dart';

class BlogImageView extends StatelessWidget {
  final Blog blog;
  const BlogImageView({required this.blog, super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: blog.aspectRatio,
      child: Image.network(
        blog.fileUrl,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
