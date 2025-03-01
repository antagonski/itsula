import 'package:flutter/foundation.dart' show immutable, VoidCallback;
import 'package:flutter/material.dart' show TextStyle, Colors, TextDecoration;
import 'package:itsula/views/components/rich_text/link_text.dart';
import 'package:itsula/views/constants/app_colors.dart';

@immutable
class BaseText {
  final String text;
  final TextStyle? style;

  const BaseText({
    required this.text,
    this.style,
  });

  factory BaseText.plain(
          {required String text,
          VoidCallback? onTap,
          TextStyle? style = const TextStyle()}) =>
      BaseText(
        text: text,
        style: style,
      );

  factory BaseText.link(
          {required String text,
          required VoidCallback onTap,
          TextStyle? style = const TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          )}) =>
      LinkText(
        text: text,
        onTap: onTap,
        style: style == null
            ? style
            : style.copyWith(color: AppColors.accentColor),
      );
}
