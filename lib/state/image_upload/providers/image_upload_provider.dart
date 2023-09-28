import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/image_upload/notifiers/image_upload_notifier.dart';
import 'package:itsula/state/image_upload/typedefs/is_loading.dart';

final imageUploadProvider =
    StateNotifierProvider<ImageUploadNotifier, isLoading>(
  (ref) => ImageUploadNotifier(),
);
