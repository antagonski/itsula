import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BlogDateView extends StatelessWidget {
  final DateTime dateTime;
  const BlogDateView({required this.dateTime, super.key});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('hh:mm a, d MMMM, yyyy');
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        formatter.format(
          dateTime,
        ),
      ),
    );
  }
}
