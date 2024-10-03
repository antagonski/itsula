import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:itsula/state/blogary/blogs/models/blog.dart';
import 'package:itsula/views/components/animations/fof_animation_view.dart';
import 'package:itsula/views/components/animations/jumping_slime_animation_view.dart';
import 'package:video_player/video_player.dart';

class BlogVideoView extends HookWidget {
  final Blog blog;
  const BlogVideoView({required this.blog, super.key});

  @override
  Widget build(BuildContext context) {
    final controller = VideoPlayerController.networkUrl(
      Uri(
        path: blog.fileUrl,
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
          aspectRatio: blog.aspectRatio,
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
