import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/auth/providers/user_id_provider.dart';
import 'package:itsula/state/blogary/blogs/likes/models/like_dislike_request.dart';
import 'package:itsula/state/blogary/blogs/likes/providers/has_liked_blog_provider.dart';
import 'package:itsula/state/blogary/blogs/likes/providers/like_dislike_blog_provider.dart';
import 'package:itsula/state/blogary/blogs/typedefs/blog_id.dart';
import 'package:itsula/views/constants/app_colors.dart';

class LikeButton extends ConsumerWidget {
  final BlogId blogId;
  const LikeButton({required this.blogId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasLiked = ref.watch(
      hasLikedBlogProvider(
        blogId,
      ),
    );
    return hasLiked.when(
      data: (isLiked) {
        return IconButton(
          color: AppColors.textColor,
          icon: FaIcon(
            isLiked
                ? FontAwesomeIcons.solidThumbsUp
                : FontAwesomeIcons.thumbsUp,
          ),
          onPressed: () {
            final userId = ref.read(userIdProvider);
            if (userId == null) {
              return;
            }
            final likedRequest = LikeDislikeRequest(
              blogId: blogId,
              likedBy: userId,
            );
            ref.read(
              likeDislikeBlogProvider(
                likedRequest,
              ),
            );
          },
        );
      },
      error: (error, stackTrace) {
        return const Center(
          child: Icon(Icons.error_rounded),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
