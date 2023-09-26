import 'package:flutter/material.dart';
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
                child: Divider(color: Colors.grey.shade600),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  Strings.orLogInWith,
                  style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                  child: Divider(
                color: Colors.grey.shade600,
              )),
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
