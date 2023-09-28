import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/auth/providers/auth_state_provider.dart';
import 'package:itsula/state/image_upload/helpers/image_picker_helper.dart';
import 'package:itsula/state/image_upload/models/file_type.dart';
import 'package:itsula/state/post_settings/providers/post_settings_provider.dart';
import 'package:itsula/views/components/dialogs/alert_dialog_model.dart';
import 'package:itsula/views/components/dialogs/logout_dialog.dart';
import 'package:itsula/views/constants/strings.dart';
import 'package:itsula/views/create_new_post/create_new_post_view.dart';
import 'package:itsula/views/tabs/user_posts/user_posts_view.dart';

class BlogView extends ConsumerStatefulWidget {
  const BlogView({super.key});

  @override
  ConsumerState<BlogView> createState() => _BlogViewState();
}

class _BlogViewState extends ConsumerState<BlogView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Strings.appName),
          actions: [
            IconButton(
              onPressed: () async {
                final videoFile =
                    await ImagePickerHelper.pickVideoFromGallery();
                if (videoFile == null) {
                  return;
                }
                ref.refresh(postSettingProvider);
                if (!mounted) {
                  return;
                }
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CreateNewPostView(
                        file: videoFile, fileType: FileType.video),
                  ),
                );
              },
              icon: const FaIcon(
                FontAwesomeIcons.photoFilm,
              ),
            ),
            IconButton(
              onPressed: () async {
                final imageFile =
                    await ImagePickerHelper.pickImageFromGallery();
                if (imageFile == null) {
                  return;
                }
                ref.refresh(postSettingProvider);
                if (!mounted) {
                  return;
                }
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CreateNewPostView(
                        file: imageFile, fileType: FileType.image),
                  ),
                );
              },
              icon: const Icon(
                Icons.add_a_photo,
              ),
            ),
            IconButton(
              onPressed: () async {
                final result = await const LogoutDialog()
                    .present(context)
                    .then((value) => value ?? false);
                if (result) {
                  await ref.read(authStateProvider.notifier).logOut();
                }
              },
              icon: const Icon(
                Icons.logout,
              ),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.person_4_outlined,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.search,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.home,
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            UserPostsView(),
            UserPostsView(),
            UserPostsView(),
          ],
        ),
      ),
    );
  }
}
