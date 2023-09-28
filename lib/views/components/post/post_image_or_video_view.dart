import 'package:flutter/material.dart';
import 'package:itsula/state/image_upload/models/file_type.dart';
import 'package:itsula/state/posts/models/post.dart';
import 'package:itsula/views/components/post/post_image_view.dart';
import 'package:itsula/views/components/post/post_video_view.dart';

class PostImageOrVideoView extends StatelessWidget {
  final Post post;
  const PostImageOrVideoView({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    switch (post.fileType) {
      case FileType.image:
        return PostImageView(
          post: post,
        );

      case FileType.video:
        return PostVideoView(
          post: post,
        );
      default:
        return const SizedBox();
    }
  }
}
