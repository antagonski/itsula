import 'package:flutter/foundation.dart' show immutable, VoidCallback;
import 'package:itsula/views/components/rich_text/base_text.dart';

@immutable
class LinkText extends BaseText {
  final VoidCallback onTap;

  const LinkText({
    required super.text,
    required this.onTap,
    super.style,
  });
}
