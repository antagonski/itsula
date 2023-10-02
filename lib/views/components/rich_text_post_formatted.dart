import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

class RichTextPostFormatted extends StatelessWidget {
  final String username;
  final DateTime date;
  final String content;
  const RichTextPostFormatted(
      {required this.username,
      required this.date,
      required this.content,
      super.key});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('hh:mm a, d MMMM, yyyy');

    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.white70,
          height: 1.5,
        ),
        children: [
          TextSpan(
            text: "$username, ${formatter.format(date)}\n\n",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: content,
          ),
        ],
      ),
    );
  }
}
