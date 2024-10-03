import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:itsula/views/constants/app_colors.dart';

class GoogleSquareButton extends StatelessWidget {
  const GoogleSquareButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FaIcon(
        FontAwesomeIcons.google,
        size: 50.0,
        color: AppColors.primaryColor,
      ),
    );
  }
}
