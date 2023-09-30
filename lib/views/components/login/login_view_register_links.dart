import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:itsula/views/constants/strings.dart';
import 'package:itsula/views/components/rich_text/base_text.dart';
import 'package:itsula/views/components/rich_text/rich_text_widget.dart';

class LoginViewRegisterLinks extends StatelessWidget {
  const LoginViewRegisterLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return RichTextWidget(
      styleForAll: Theme.of(context).textTheme.titleSmall?.copyWith(
            height: 1.5,
          ),
      texts: [
        BaseText.plain(
          text: Strings.dontHaveAnAccount,
        ),
        BaseText.plain(text: Strings.space),
        BaseText.link(
          text: Strings.registerNow,
          onTap: () {
            if (kDebugMode) {
              print("Go to register page.");
            }
          },
        ),
      ],
    );
  }
}
