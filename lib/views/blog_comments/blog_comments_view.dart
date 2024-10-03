import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/auth/providers/user_id_provider.dart';
import 'package:itsula/state/blogary/comments/models/request_for_blog_and_comments.dart';
import 'package:itsula/state/blogary/comments/providers/blog_comments_provider.dart';
import 'package:itsula/state/blogary/comments/providers/send_comment_provider.dart';
import 'package:itsula/state/blogary/blogs/typedefs/blog_id.dart';
import 'package:itsula/views/components/comment/comment_tile.dart';
import 'package:itsula/views/components/animations/empty_contents_with_text_animation_view.dart';
import 'package:itsula/views/components/animations/fof_animation_view.dart';
import 'package:itsula/views/components/animations/jumping_slime_animation_view.dart';
import 'package:itsula/views/constants/app_colors.dart';
import 'package:itsula/views/constants/strings.dart';
import 'package:itsula/views/extensions/dismiss_keyboard.dart';

class BlogCommentsView extends HookConsumerWidget {
  final BlogId blogId;
  const BlogCommentsView({required this.blogId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentController = useTextEditingController();
    final hasText = useState(false);
    final request = useState(
      RequestForBlogAndComments(
        blogId: blogId,
      ),
    );

    final comments = ref.watch(
      blogCommentsProvider(request.value),
    );

    useEffect(
      () {
        commentController.addListener(
          () {
            hasText.value = commentController.text.isNotEmpty;
          },
        );
        return () {};
      },
      [commentController],
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        centerTitle: true,
        title: const Text(Strings.comments),
        actions: [
          IconButton(
            color: AppColors.textColor,
            onPressed: hasText.value
                ? () {
                    _submitCommentWithController(
                      commentController,
                      ref,
                    );
                  }
                : null,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 4,
              child: comments.when(data: (comments) {
                if (comments.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: () {
                      ref.refresh(
                        blogCommentsProvider(
                          request.value,
                        ),
                      );
                      return Future.delayed(
                        const Duration(seconds: 1),
                      );
                    },
                    child: const SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: EmptyContentsWithTextAnimationView(
                        text: Strings.noCommentsYet,
                      ),
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () {
                    ref.refresh(
                      blogCommentsProvider(
                        request.value,
                      ),
                    );
                    return Future.delayed(
                      const Duration(seconds: 1),
                    );
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final comment = comments.elementAt(index);
                      return CommentTile(comment: comment);
                    },
                  ),
                );
              }, error: (error, stackTrace) {
                return const FoFAnimationView();
              }, loading: () {
                return const JumpingSlimeAnimationView();
              }),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    textInputAction: TextInputAction.send,
                    controller: commentController,
                    onSubmitted: (comment) {
                      if (comment.isNotEmpty) {
                        _submitCommentWithController(
                          commentController,
                          ref,
                        );
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 26, horizontal: 12),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.textColor.withAlpha(
                            100,
                          ),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.textColor),
                      ),
                      fillColor: AppColors.secondaryColor,
                      filled: true,
                      hintText: Strings.writeYourCommentHere,
                      hintStyle: TextStyle(
                        color: AppColors.textColor.withAlpha(
                          100,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitCommentWithController(
      TextEditingController controller, WidgetRef ref) async {
    final userId = ref.read(userIdProvider);
    if (userId == null) {
      return;
    }
    final isSent = await ref.read(sendCommentProvider.notifier).sendComment(
          fromUserId: userId,
          onBlogId: blogId,
          comment: controller.text,
        );
    if (isSent) {
      controller.clear();
      dismissKeyboard();
    }
  }
}
