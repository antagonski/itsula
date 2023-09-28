import 'package:itsula/views/components/animations/lottie_animation_view.dart';
import 'package:itsula/views/components/animations/models/lottie_animation.dart';

class EmptyBoxAnimationView extends LottieAnimationView {
  const EmptyBoxAnimationView({super.key})
      : super(
          animation: LottieAnimation.emptyBox,
        );
}
