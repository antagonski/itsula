import 'package:flutter/material.dart';
import 'package:itsula/state/constants/homepage_side_bar_app_name.dart';

class HabtrackView extends StatelessWidget {
  const HabtrackView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'This is ${HomePageSideBarAppName.habtrack}.',
        ),
      ),
    );
  }
}
