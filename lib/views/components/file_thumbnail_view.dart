import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/image_upload/models/thumbnail_request.dart';
import 'package:itsula/state/image_upload/providers/thumbnail_provider.dart';
import 'package:itsula/views/components/animations/fof_animation_view.dart';
import 'package:itsula/views/components/animations/jumping_slime_animation_view.dart';

class FileThumbnailView extends ConsumerWidget {
  final ThumbnailRequest thumbnailRequest;

  const FileThumbnailView({
    required this.thumbnailRequest,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thumbnail = ref.watch(thumbnailProvider(
      thumbnailRequest,
    ));
    return thumbnail.when(data: (imageWithAspectRatio) {
      return AspectRatio(
        aspectRatio: imageWithAspectRatio.aspectRatio,
        child: imageWithAspectRatio.image,
      );
    }, error: (error, stackTrace) {
      return const FoFAnimationView();
    }, loading: () {
      return const JumpingSlimeAnimationView();
    });
  }
}
