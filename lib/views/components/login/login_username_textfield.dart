import 'package:flutter/material.dart';
import 'package:itsula/views/constants/app_colors.dart';

class LoginUsernameTextfield extends StatelessWidget {
  final String hintText;
  final bool obscureText;

  const LoginUsernameTextfield({
    super.key,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25.0,
      ),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 26, horizontal: 12),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.textColor.withAlpha(
                100,
              ),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textColor),
          ),
          fillColor: AppColors.secondaryColor,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColors.textColor.withAlpha(
              100,
            ),
          ),
        ),
      ),
    );
  }
}
