import 'package:flutter/material.dart';
import 'package:itsula/views/constants/app_colors.dart';
import 'package:itsula/views/constants/strings.dart';

class DividerWithMarginsAndText extends StatelessWidget {
  const DividerWithMarginsAndText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            children: [
              Expanded(
                child: Divider(
                  color: AppColors.textColor.withAlpha(
                    100,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  Strings.orLogInWith,
                  style: TextStyle(
                      color: AppColors.textColor.withAlpha(
                        100,
                      ),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Divider(
                  color: AppColors.textColor.withAlpha(
                    100,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 40.0,
        ),
      ],
    );
  }
}
