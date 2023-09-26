import 'package:flutter/material.dart';
import 'package:itsula/views/constants/strings.dart';
import 'package:itsula/views/components/rich_text/base_text.dart';
import 'package:itsula/views/components/rich_text/rich_text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterViewRegisterLinks extends StatelessWidget {
  const RegisterViewRegisterLinks({super.key});

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
        BaseText.plain(
          text: Strings.registerHere,
        ),
        BaseText.link(
          text: Strings.google,
          onTap: () {
            launchUrl(
              Uri.parse(Strings.googleRegisterUrl),
            );
          },
        ),
        BaseText.plain(text: Strings.newLine),
        BaseText.link(
          text: Strings.orRegisterWithEmailAndPasword,
          onTap: () {},
        ),
      ],
    );
  }
}
