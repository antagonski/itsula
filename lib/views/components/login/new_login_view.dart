import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/auth/providers/auth_state_provider.dart';
import 'package:itsula/views/components/login/divider_with_margins_and_text.dart';
import 'package:itsula/views/components/login/forgot_password_link.dart';
import 'package:itsula/views/components/login/google_square_button.dart';
import 'package:itsula/views/components/login/login_button.dart';
import 'package:itsula/views/components/login/login_username_textfield.dart';
import 'package:itsula/views/components/login/login_password_textfield.dart';
import 'package:itsula/views/components/login/login_view_register_links.dart';
import 'package:itsula/views/constants/app_colors.dart';
import 'package:itsula/views/constants/strings.dart';

//
class NewLoginView extends ConsumerWidget {
  const NewLoginView({super.key});

  @override
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                Image.asset(
                  "assets/images/duality_logo_01.png",
                  scale: 10,
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  Strings.welcomeMessage,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 25,
                ),
                const LoginUsernameTextfield(
                  hintText: Strings.emailHint,
                  obscureText: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                const LoginPasswordTextfield(
                  hintText: Strings.passwordHint,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 25.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [ForgotPasswordLink()]),
                ),
                const SizedBox(height: 25.0),
                const LoginButton(),
                const DividerWithMarginsAndText(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(16.0),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: AppColors.textColor, width: 2.0),
                            borderRadius: BorderRadius.circular(16)),
                        backgroundColor: AppColors.secondaryColor,
                      ),
                      onPressed:
                          ref.read(authStateProvider.notifier).logInWithGoogle,
                      child: const GoogleSquareButton(),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50.0,
                ),
                const LoginViewRegisterLinks(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
