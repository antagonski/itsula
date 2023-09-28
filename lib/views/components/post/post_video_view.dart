import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:itsula/state/posts/models/post.dart';
import 'package:itsula/views/components/animations/fof_animation_view.dart';
import 'package:itsula/views/components/animations/jumping_slime_animation_view.dart';
import 'package:video_player/video_player.dart';

class PostVideoView extends HookWidget {
  final Post post;
  const PostVideoView({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    final controller = VideoPlayerController.networkUrl(
      Uri(
        path: post.fileUrl,
      ),
    );
    final isVideoPlayerReady = useState(false);

    useEffect(
      () {
        controller.initialize().then(
          (value) {
            isVideoPlayerReady.value = true;
            controller.setLooping(true);
            controller.play();
          },
        );
        return controller.dispose;
      },
    );

    switch (isVideoPlayerReady.value) {
      case true:
        return AspectRatio(
          aspectRatio: post.aspectRatio,
          child: VideoPlayer(controller),
        );
      case false:
        return const JumpingSlimeAnimationView();
      default:
        //defualt should in theory never be called
        return const FoFAnimationView();
    }
  }
}
