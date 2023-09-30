import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/auth/providers/user_id_provider.dart';
import 'package:itsula/state/likes/models/like_dislike_request.dart';
import 'package:itsula/state/likes/providers/has_liked_post_provider.dart';
import 'package:itsula/state/likes/providers/like_dislike_post_provider.dart';
import 'package:itsula/state/posts/typedefs/post_id.dart';

class LikeButton extends ConsumerWidget {
  final PostId postId;
  const LikeButton({required this.postId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasLiked = ref.watch(
      hasLikedPostProvider(
        postId,
      ),
    );
    return hasLiked.when(
      data: (isLiked) {
        return IconButton(
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
              postId: postId,
              likedBy: userId,
            );
            ref.read(
              likeDislikePostProvider(
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
