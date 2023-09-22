import 'package:flutter/material.dart';

class DummyPage extends StatelessWidget {
  const DummyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 100.0, right: 50.0),
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(color: Colors.pink),
              ),
            ),
          ),
          Center(
            child: FilledButton(
              onPressed: () {},
              child: const Text("HARO"),
            ),
          ),
        ],
      ),
    );
  }
}
