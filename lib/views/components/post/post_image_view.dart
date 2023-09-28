import 'package:flutter/material.dart';
import 'package:itsula/state/posts/models/post.dart';

class PostImageView extends StatelessWidget {
  final Post post;
  const PostImageView({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: post.aspectRatio,
      child: Image.network(
        post.fileUrl,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
