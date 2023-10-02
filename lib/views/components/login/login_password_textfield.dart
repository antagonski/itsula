import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/auth/providers/is_password_showing_provider.dart';
import 'package:itsula/views/constants/app_colors.dart';

class LoginPasswordTextfield extends ConsumerWidget {
  final String hintText;

  const LoginPasswordTextfield({
    super.key,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25.0,
        ),
        child: Consumer(
          builder: (context, ref, child) {
            final shouldObscure = ref.watch(isPasswordShowingProvider);
            return TextField(
              obscureText: shouldObscure,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                suffix: GestureDetector(
                  child: Icon(
                      shouldObscure ? Icons.visibility_off : Icons.visibility),
                  onTap: () {
                    ref
                        .read(isPasswordShowingProvider.notifier)
                        .updatePasswordShowingStatus();
                  },
                ),
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
            );
          },
        ));
  }
}
