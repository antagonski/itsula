import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/blogary/providers/blogary_fab_provider.dart';
import 'package:itsula/state/image_upload/constants/constants.dart';
import 'package:itsula/state/image_upload/helpers/image_picker_helper.dart';
import 'package:itsula/state/image_upload/models/file_type.dart';
import 'package:itsula/state/post_settings/providers/post_settings_provider.dart';
import 'package:itsula/views/constants/app_colors.dart';
import 'package:itsula/views/create_new_post/create_new_post_view.dart';

class CustomBlogaryFabView extends ConsumerStatefulWidget {
  const CustomBlogaryFabView({
    super.key,
  });

  @override
  CustomBlogaryFabViewState createState() => CustomBlogaryFabViewState();
}

class CustomBlogaryFabViewState extends ConsumerState<CustomBlogaryFabView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _translateButtonAnimation;
  late Animation<double> _animateIcon;
  final double _fabHeight = 56.0;
  final Curve _curve = Curves.easeIn;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 375,
      ),
    )..addListener(
        () {
          setState(
            () {},
          );
        },
      );

    _animateIcon = Tween<double>(begin: 0.0, end: 1.0).animate(
      _animationController,
    );

    _translateButtonAnimation = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.75, curve: _curve),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!ref.watch(blogaryFabProvider)) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    ref.read(blogaryFabProvider.notifier).changeHideShowStatus();
  }

  Widget blogaryPostWithoutImageOrVideo() {
    return SizedBox(
      child: FloatingActionButton(
        backgroundColor: AppColors.accentColor,
        foregroundColor: AppColors.textColor,
        heroTag: 'bpwiov',
        tooltip: 'Add just a blogary post, no image or video needed.',
        onPressed: () async {
          animate();
          //TODO implement a post without an image.
          final f = File(Constants.defaultImageRelativePath);
          ref.refresh(postSettingProvider);
          if (!mounted) {
            return;
          }
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) =>
                  CreateNewPostView(file: f, fileType: FileType.image),
            ),
          );
        },
        child: const Icon(
          Icons.note_add,
        ),
      ),
    );
  }

  Widget blogaryPostWithImage() {
    return SizedBox(
      child: FloatingActionButton(
        backgroundColor: AppColors.accentColor,
        foregroundColor: AppColors.textColor,
        heroTag: 'bpwi',
        tooltip: 'Add a blogary post with an image.',
        onPressed: () async {
          animate();
          final imageFile = await ImagePickerHelper.pickImageFromGallery();
          if (imageFile == null) {
            return;
          }
          ref.refresh(postSettingProvider);
          if (!mounted) {
            return;
          }
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) =>
                  CreateNewPostView(file: imageFile, fileType: FileType.image),
            ),
          );
        },
        child: const Icon(
          Icons.add_a_photo,
        ),
      ),
    );
  }

  Widget blogaryPostWithVideo() {
    return SizedBox(
      child: FloatingActionButton(
        backgroundColor: AppColors.accentColor,
        foregroundColor: AppColors.textColor,
        heroTag: 'bpwv',
        tooltip: 'Add a blogary post with a video.',
        onPressed: () async {
          animate();
          final videoFile = await ImagePickerHelper.pickVideoFromGallery();
          if (videoFile == null) {
            return;
          }
          ref.refresh(postSettingProvider);
          if (!mounted) {
            return;
          }
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) =>
                  CreateNewPostView(file: videoFile, fileType: FileType.video),
            ),
          );
        },
        child: const FaIcon(
          FontAwesomeIcons.film,
        ),
      ),
    );
  }

  Widget toggle() {
    return SizedBox(
      height: 70 - _animationController.value * 30,
      width: 70 - _animationController.value * 30,
      child: FloatingActionButton(
        heroTag: 'toggle',
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.textColor,
        tooltip: 'Choose how you want to make a new post!',
        onPressed: animate,
        child: AnimatedIcon(
            icon: AnimatedIcons.menu_close, progress: _animateIcon),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButtonAnimation.value * 3.0,
            0.0,
          ),
          child: blogaryPostWithVideo(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButtonAnimation.value * 2.0,
            0.0,
          ),
          child: blogaryPostWithImage(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButtonAnimation.value,
            0.0,
          ),
          child: blogaryPostWithoutImageOrVideo(),
        ),
        toggle(),
      ],
    );
  }
}
