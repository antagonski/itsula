import 'package:flutter/material.dart';
import 'package:itsula/state/posts/models/post.dart';
import 'package:itsula/views/components/post/post_thumbnail_view.dart';

class PostGridView extends StatelessWidget {
  final Iterable<Post> posts;
  const PostGridView({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts.elementAt(index);
        return PostThumbnailView(
            post: post,
            onTap: () {
              //TODO add page for blog post view
              /*Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return PostCommentsView(
                      postId: post.postId,
                    );
                  },
                ),
              );*/
            });
      },
    );
  }
}
