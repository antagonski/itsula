import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/auth/providers/user_id_provider.dart';
import 'package:itsula/state/image_upload/models/file_type.dart';
import 'package:itsula/state/image_upload/models/thumbnail_request.dart';
import 'package:itsula/state/image_upload/providers/image_upload_provider.dart';
import 'package:itsula/state/blog_settings/models/blog_setting.dart';
import 'package:itsula/state/blog_settings/providers/blog_settings_provider.dart';
import 'package:itsula/views/components/file_thumbnail_view.dart';
import 'package:itsula/views/constants/strings.dart';

class CreateNewBlogView extends StatefulHookConsumerWidget {
  final File file;
  final FileType fileType;
  const CreateNewBlogView(
      {required this.file, required this.fileType, super.key});

  @override
  ConsumerState<CreateNewBlogView> createState() => _CreateNewBlogViewState();
}

class _CreateNewBlogViewState extends ConsumerState<CreateNewBlogView> {
  @override
  Widget build(BuildContext context) {
    final thumbnailRequest = ThumbnailRequest(
      file: widget.file,
      fileType: widget.fileType,
    );

    final blogSettings = ref.watch(blogSettingProvider);
    final blogController = useTextEditingController();
    final isBlogButtonEnabled = useState(false);
    useEffect(
      () {
        void listener() {
          isBlogButtonEnabled.value = blogController.text.isNotEmpty;
        }

        blogController.addListener(listener);

        return () {
          blogController.removeListener(listener);
        };
      },
      [blogController],
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.createNewBlog,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.post_add,
            ),
            tooltip: Strings.addANewBlog,
            onPressed: isBlogButtonEnabled.value
                ? () async {
                    final userId = ref.read(
                      userIdProvider,
                    );
                    if (userId == null) {
                      if (kDebugMode) {
                        print("User ID is null.");
                      }
                      return;
                    }
                    final message = blogController.text;
                    final isUploaded =
                        await ref.read(imageUploadProvider.notifier).upload(
                              file: widget.file,
                              fileType: widget.fileType,
                              message: message,
                              blogSettings: blogSettings,
                              userId: userId,
                            );
                    if (isUploaded && mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                : null,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //thumbnail
            FileThumbnailView(thumbnailRequest: thumbnailRequest),
            //textfield
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: Strings.pleaseWriteYourMessageHere,
                ),
                autofocus: true,
                maxLines: null,
                controller: blogController,
              ),
            ),
            ...BlogSetting.values.map(
              (blogSetting) => ListTile(
                title: Text(blogSetting.title),
                subtitle: Text(
                  blogSetting.description,
                ),
                trailing: Switch(
                  value: blogSettings[blogSetting] ?? false,
                  onChanged: (isOn) {
                    ref.read(blogSettingProvider.notifier).setSetting(
                          blogSetting,
                          isOn,
                        );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
