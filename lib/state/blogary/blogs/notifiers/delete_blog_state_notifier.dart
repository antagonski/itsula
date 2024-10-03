import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/constants/firebase_collection_name.dart';
import 'package:itsula/state/constants/firebase_field_name.dart';
import 'package:itsula/state/image_upload/extensions/get_collection_name_from_file_type.dart';
import 'package:itsula/state/image_upload/typedefs/is_loading.dart';
import 'package:itsula/state/blogary/blogs/models/blog.dart';
import 'package:itsula/state/blogary/blogs/typedefs/blog_id.dart';

class DeleteBlogStateNotifier extends StateNotifier<IsLoading> {
  DeleteBlogStateNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> deleteBlog({required Blog blog}) async {
    try {
      isLoading = true;
      //delete blog's thumbnail
      await FirebaseStorage.instance
          .ref()
          .child(blog.userId)
          .child(FirebaseCollectionName.thumbnails)
          .child(blog.thumbnailStorageId)
          .delete();
      //delete blog's original file
      await FirebaseStorage.instance
          .ref()
          .child(blog.userId)
          .child(blog.fileType.collectionName)
          .child(blog.originalFileStorageId)
          .delete();
      //delete all of the blog's comments
      await _deleteAllDocuments(
          blogId: blog.blogId, inCollection: FirebaseCollectionName.comments);
      //delete all of the blog's likes
      await _deleteAllDocuments(
          blogId: blog.blogId, inCollection: FirebaseCollectionName.likes);
      //delete the blog itself
      final blogInCollection = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.blogs)
          .where(
            FieldPath.documentId,
            isEqualTo: blog.blogId,
          )
          .limit(1)
          .get();
      for (final thisBlog in blogInCollection.docs) {
        await thisBlog.reference.delete();
      }
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }

  Future<void> _deleteAllDocuments(
      {required BlogId blogId, required String inCollection}) {
    return FirebaseFirestore.instance.runTransaction(
      maxAttempts: 3,
      timeout: const Duration(seconds: 20),
      (transaction) async {
        final query = await FirebaseFirestore.instance
            .collection(inCollection)
            .where(FirebaseFieldName.blogId, isEqualTo: blogId)
            .get();

        for (final doc in query.docs) {
          transaction.delete(doc.reference);
        }
      },
    );
  }
}
