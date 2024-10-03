import 'package:flutter/material.dart';
import 'package:itsula/state/blogary/blogs/models/blog.dart';
import 'package:itsula/views/components/blog/blog_thumbnail_view.dart';
import 'package:itsula/views/blog_details/blog_details_view.dart';

class BlogGridView extends StatelessWidget {
  final Iterable<Blog> blogs;
  const BlogGridView({super.key, required this.blogs});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemCount: blogs.length,
      itemBuilder: (context, index) {
        final blog = blogs.elementAt(index);
        return BlogThumbnailView(
          blog: blog,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BlogDetailsView(
                  blog: blog,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
