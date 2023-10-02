import 'package:flutter/material.dart';
import 'package:itsula/views/blog/blogary_view.dart';
import 'package:itsula/views/habtrack/habtrack_view.dart';
import 'package:itsula/views/letters/letters_view.dart';

Widget applicationListView({required int index}) {
  List<Widget> screens = [
    const BlogaryView(),
    const HabtrackView(),
    const LettersView(),
  ];
  return screens[index];
}
