import 'package:flutter/material.dart';
import 'package:itsula/state/image_upload/models/file_type.dart';
import 'package:itsula/state/blogary/blogs/models/blog.dart';
import 'package:itsula/views/components/blog/blog_image_view.dart';
import 'package:itsula/views/components/blog/blog_video_view.dart';

class BlogImageOrVideoView extends StatelessWidget {
  final Blog blog;
  const BlogImageOrVideoView({required this.blog, super.key});

  @override
  Widget build(BuildContext context) {
    switch (blog.fileType) {
      case FileType.image:
        return BlogImageView(
          blog: blog,
        );

      case FileType.video:
        return BlogVideoView(
          blog: blog,
        );
      default:
        return const SizedBox();
    }
  }
}
