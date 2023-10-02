import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart' show Colors;
import 'package:itsula/extensions/string/as_html_color_to_color.dart';

@immutable
class AppColors {
  static final loginButtonColor = '#cfc9c2'.htmlColorToColor();
  static const loginButtonTextColor = Colors.black;
  static final googleColor = '#4285f4'.htmlColorToColor();
  static final facebookColor = '#3b5998'.htmlColorToColor();

  static final textColor = '#f2eeee'.htmlColorToColor();
  static final backgroundColor = '#27211f'.htmlColorToColor();
  static final primaryColor = '#7a0b06'.htmlColorToColor();
  static final secondaryColor = '#1d2126'.htmlColorToColor();
  static final accentColor = '#769888'.htmlColorToColor();

  const AppColors._();
}
