import 'package:flutter/material.dart';
import 'package:itsula/state/blogary/blogs/models/blog.dart';

class BlogThumbnailView extends StatelessWidget {
  final Blog blog;
  final VoidCallback onTap;

  const BlogThumbnailView({super.key, required this.blog, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Image.network(
          blog.thumbnailUrl,
          fit: BoxFit.cover,
        ));
  }
}
