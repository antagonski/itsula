import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/enums/date_sorting.dart';
import 'package:itsula/state/blogary/comments/models/request_for_blog_and_comments.dart';
import 'package:itsula/state/blogary/blogs/models/blog.dart';
import 'package:itsula/state/blogary/blogs/providers/delete_blog_provider.dart';
import 'package:itsula/state/blogary/blogs/providers/is_this_my_blog_provider.dart';
import 'package:itsula/state/blogary/blogs/providers/specific_blog_with_comments_provider.dart';
import 'package:itsula/views/components/animations/fof_animation_view.dart';
import 'package:itsula/views/components/animations/jumping_slime_animation_view.dart';
import 'package:itsula/views/components/blog/blog_image_or_video_view.dart';
import 'package:itsula/views/components/comment/compact_comment_column.dart';
import 'package:itsula/views/components/dialogs/alert_dialog_model.dart';
import 'package:itsula/views/components/dialogs/delete_dialog.dart';
import 'package:itsula/views/components/like_button.dart';
import 'package:itsula/views/components/likes_count_view.dart';
import 'package:itsula/views/components/blog/blog_display_name_message_and_date_view.dart';
import 'package:itsula/views/constants/app_colors.dart';
import 'package:itsula/views/constants/strings.dart';
import 'package:itsula/views/blog_comments/blog_comments_view.dart';
import 'package:share_plus/share_plus.dart';

class BlogDetailsView extends ConsumerStatefulWidget {
  final Blog blog;
  const BlogDetailsView({required this.blog, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BlogDetailsViewState();
}

class _BlogDetailsViewState extends ConsumerState<BlogDetailsView> {
  @override
  Widget build(BuildContext context) {
    final request = RequestForBlogAndComments(
      blogId: widget.blog.blogId,
      limit: 3,
      sortByCreatedAt: true,
      dateSorting: DateSorting.oldestOnTop,
    );
    //getting actual blog together with the comments
    final blogWithComments = ref.watch(
      specificBlogWithCommentsProvider(
        request,
      ),
    );

    //can we delete this blog?

    final isThisOurBlog = ref.watch(
      isThisMyBlogProvider(
        widget.blog,
      ),
    );
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        centerTitle: true,
        title: const Text(
          Strings.blogDetails,
        ),
        actions: [
          blogWithComments.when(
            data: (thisBlogWithComments) {
              return IconButton(
                color: AppColors.textColor,
                onPressed: () {
                  final url = thisBlogWithComments.blog.fileUrl;
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
          if (isThisOurBlog.value ?? false)
            IconButton(
              color: AppColors.textColor,
              onPressed: () async {
                final shouldDeleteBlog = await const DeleteDialog(
                  titleOfObjectToDelete: Strings.blog,
                ).present(context).then(
                      (shouldDeleteOrNot) => shouldDeleteOrNot ?? false,
                    );
                if (shouldDeleteBlog) {
                  await ref.read(deleteBlogProvider.notifier).deleteBlog(
                        blog: widget.blog,
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
      body: blogWithComments.when(data: (thisBlogWithComments) {
        final blogId = thisBlogWithComments.blog.blogId;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlogImageOrVideoView(
                blog: thisBlogWithComments.blog,
              ),
              //TODO MAKE IT THE LAYOUT WE WANT KEK
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (thisBlogWithComments.blog.allowLikes)
                        LikeButton(
                          blogId: blogId,
                        ),
                      if (thisBlogWithComments.blog.allowComments)
                        IconButton(
                          color: AppColors.textColor,
                          onPressed: () {
                            Navigator.of(context).push(
                              (MaterialPageRoute(
                                builder: (context) {
                                  return BlogCommentsView(
                                    blogId: thisBlogWithComments.blog.blogId,
                                  );
                                },
                              )),
                            );
                          },
                          icon: const Icon(
                            Icons.comment,
                          ),
                        ),
                    ],
                  ),
                  if (thisBlogWithComments.blog.allowLikes)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 16.0,
                        bottom: 2.0,
                      ),
                      child: Row(
                        children: [
                          LikeCountView(
                            blogId: blogId,
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
              BlogDisplayNameMessageAndDateView(
                blog: thisBlogWithComments.blog,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Divider(
                  color: AppColors.accentColor,
                ),
              ),

              CompactCommentColumn(
                comments: thisBlogWithComments.comments,
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
