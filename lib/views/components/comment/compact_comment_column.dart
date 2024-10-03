import 'package:flutter/material.dart';
import 'package:itsula/state/blogary/comments/models/comment.dart';
import 'package:itsula/views/components/comment/compact_comment_tile.dart';

class CompactCommentColumn extends StatelessWidget {
  final Iterable<Comment> comments;
  const CompactCommentColumn({required this.comments, super.key});

  @override
  Widget build(BuildContext context) {
    if (comments.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: comments.map((comment) {
          return CompactCommentTile(
            comment: comment,
          );
        }).toList(),
      ),
    );
  }
}
