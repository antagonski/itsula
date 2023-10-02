import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/enums/date_sorting.dart';
import 'package:itsula/state/comments/models/request_for_post_and_comments.dart';
import 'package:itsula/state/posts/models/post.dart';
import 'package:itsula/state/posts/providers/delete_post_provider.dart';
import 'package:itsula/state/posts/providers/is_this_my_post_provider.dart';
import 'package:itsula/state/posts/providers/specific_post_with_comments_provider.dart';
import 'package:itsula/views/components/animations/fof_animation_view.dart';
import 'package:itsula/views/components/animations/jumping_slime_animation_view.dart';
import 'package:itsula/views/components/comment/compact_comment_column.dart';
import 'package:itsula/views/components/dialogs/alert_dialog_model.dart';
import 'package:itsula/views/components/dialogs/delete_dialog.dart';
import 'package:itsula/views/components/like_button.dart';
import 'package:itsula/views/components/likes_count_view.dart';
import 'package:itsula/views/components/post/post_date_view.dart';
import 'package:itsula/views/components/post/post_display_name_message_and_date_view.dart';
import 'package:itsula/views/components/post/post_image_or_video_view.dart';
import 'package:itsula/views/constants/app_colors.dart';
import 'package:itsula/views/constants/strings.dart';
import 'package:itsula/views/post_comments/post_comments_view.dart';
import 'package:share_plus/share_plus.dart';

class PostDetailsView extends ConsumerStatefulWidget {
  final Post post;
  const PostDetailsView({required this.post, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PostDetailsViewState();
}

class _PostDetailsViewState extends ConsumerState<PostDetailsView> {
  @override
  Widget build(BuildContext context) {
    final request = RequestForPostAndComments(
      postId: widget.post.postId,
      limit: 3,
      sortByCreatedAt: true,
      dateSorting: DateSorting.oldestOnTop,
    );
    //getting actual post together with the comments
    final postWithComments = ref.watch(
      specificPostWithCommentsProvider(
        request,
      ),
    );

    //can we delete this post?

    final isThisOurPost = ref.watch(
      isThisMyPostProvider(
        widget.post,
      ),
    );
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        centerTitle: true,
        title: const Text(
          Strings.postDetails,
        ),
        actions: [
          postWithComments.when(
            data: (thisPostWithComments) {
              return IconButton(
                color: AppColors.textColor,
                onPressed: () {
                  final url = thisPostWithComments.post.fileUrl;
                  Share.share(url, subject: Strings.checkTHISout);
                },
                icon: const Icon(
                  Icons.share,
                ),
              );
            },
            error: (error, stackTrace) {
              return const Center(
                child: Icon(
                  Icons.error,
                ),
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          if (isThisOurPost.value ?? false)
            IconButton(
              color: AppColors.textColor,
              onPressed: () async {
                final shouldDeletePost = await const DeleteDialog(
                  titleOfObjectToDelete: Strings.post,
                ).present(context).then(
                      (shouldDeleteOrNot) => shouldDeleteOrNot ?? false,
                    );
                if (shouldDeletePost) {
                  await ref.read(deletePostProvider.notifier).deletePost(
                        post: widget.post,
                      );
                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                }
              },
              icon: const Icon(
                Icons.delete,
              ),
            ),
        ],
      ),
      body: postWithComments.when(data: (thisPostWithComments) {
        final postId = thisPostWithComments.post.postId;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PostImageOrVideoView(
                post: thisPostWithComments.post,
              ),
              //TODO MAKE IT THE LAYOUT WE WANT KEK
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (thisPostWithComments.post.allowLikes)
                        LikeButton(
                          postId: postId,
                        ),
                      if (thisPostWithComments.post.allowComments)
                        IconButton(
                          color: AppColors.textColor,
                          onPressed: () {
                            Navigator.of(context).push((MaterialPageRoute(
                              builder: (context) {
                                return PostCommentsView(
                                  postId: thisPostWithComments.post.postId,
                                );
                              },
                            )));
                          },
                          icon: const Icon(
                            Icons.comment,
                          ),
                        ),
                    ],
                  ),
                  if (thisPostWithComments.post.allowLikes)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 16.0,
                        bottom: 2.0,
                      ),
                      child: Row(
                        children: [
                          LikeCountView(
                            postId: postId,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: Divider(
                  color: AppColors.accentColor,
                  height: 1,
                ),
              ),
              //here comes the rest
              PostDisplayNameMessageAndDateView(
                post: thisPostWithComments.post,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Divider(
                  color: AppColors.accentColor,
                ),
              ),

              CompactCommentColumn(
                comments: thisPostWithComments.comments,
              ),

              const SizedBox(
                height: 100.0,
              ),
            ],
          ),
        );
      }, error: (error, stackTrace) {
        return const Center(child: FoFAnimationView());
      }, loading: () {
        return const Center(child: JumpingSlimeAnimationView());
      }),
    );
  }
}
