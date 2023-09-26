import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:itsula/views/constants/app_colors.dart';

class GoogleSquareButton extends StatelessWidget {
  const GoogleSquareButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      /*padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(16.0),
          color: AppColors.loginButtonColor),*/
      child: FaIcon(
        FontAwesomeIcons.google,
        size: 50.0,
        color: AppColors.googleColor,
      ),
    );
  }
}
