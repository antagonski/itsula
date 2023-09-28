import 'package:flutter/material.dart';
import 'package:itsula/views/components/animations/empty_box_animation_view.dart';

class DummyPage extends StatelessWidget {
  const DummyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: EmptyBoxAnimationView(),
        ),
      ),
    );
  }
}
