import 'package:flutter/material.dart';
import 'package:itsula/views/constants/strings.dart';
import 'package:itsula/views/components/rich_text/base_text.dart';
import 'package:itsula/views/components/rich_text/rich_text_widget.dart';

class ForgotPasswordLink extends StatelessWidget {
  const ForgotPasswordLink({super.key});

  @override
  Widget build(BuildContext context) {
    return RichTextWidget(
      styleForAll: Theme.of(context).textTheme.titleSmall?.copyWith(
            height: 1.5,
          ),
      texts: [
        BaseText.link(
          text: Strings.forgotPaswordQuestionMark,
          onTap: () {},
        ),
      ],
    );
  }
}
