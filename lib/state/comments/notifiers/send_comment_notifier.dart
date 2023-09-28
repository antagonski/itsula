import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/comments/models/comment_payload.dart';
import 'package:itsula/state/constants/firebase_collection_name.dart';
import 'package:itsula/state/image_upload/typedefs/is_loading.dart';
import 'package:itsula/state/posts/typedefs/post_id.dart';
import 'package:itsula/state/posts/typedefs/user_id.dart';

class SendCommentNotifier extends StateNotifier<isLoading> {
  SendCommentNotifier() : super(false);

  set isLoading(bool value) => state = value;
  Future<bool> sendComment(
      {required UserId fromUserId,
      required PostId onPostId,
      required String comment}) async {
    isLoading = true;
    try {
      final payload = CommentPayload(
        fromUserId: fromUserId,
        onPostId: onPostId,
        comment: comment,
      );
      await FirebaseFirestore.instance
          .collection(FirebaseCollectiondName.comments)
          .add(payload);

      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
