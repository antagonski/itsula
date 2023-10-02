import 'package:flutter/material.dart';
import 'package:itsula/views/blog/components/custom_blogary_fab.dart';

class DummyPage extends StatelessWidget {
  const DummyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            "ddd",
          ),
        ),
      ),
      floatingActionButton: CustomBlogaryFabView(),
    );
  }
}
