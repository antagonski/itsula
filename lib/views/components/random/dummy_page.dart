import 'package:flutter/material.dart';
import 'package:itsula/views/components/animations/my_animation_01_animation_view.dart';

class DummyPage extends StatelessWidget {
  const DummyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: MyAnimation01AnimationView(),
      ),
    );
  }
}
