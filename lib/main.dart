import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/firebase_options.dart';

import 'dart:developer' as devtools show log;

import 'package:itsula/state/auth/providers/is_logged_in_provider.dart';
import 'package:itsula/state/providers/is_loading_provider.dart';
import 'package:itsula/views/components/loading/loading_screen.dart';
import 'package:itsula/views/components/login/new_login_view.dart';
import 'package:itsula/views/constants/app_colors.dart';
import 'package:itsula/views/homepage/homepage_view.dart';

extension Log on Object {
  void log() => devtools.log(
        toString(),
      );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: AppColors.textColor, //<-- SEE HERE
                displayColor: AppColors.textColor, //<-- SEE HERE
              ),
          brightness: Brightness.dark,
          primarySwatch: Colors.blueGrey,
          indicatorColor: Colors.blueGrey),
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.lightBlue,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: Consumer(
        builder: (context, ref, child) {
          ref.listen<bool>(
            isLoadingProvider,
            (_, isLoading) {
              if (isLoading) {
                LoadingScreen.instance().show(
                  context: context,
                );
              } else {
                if (kDebugMode) {
                  print("inside else before hiding loading screen.");
                }
                LoadingScreen.instance().hide();
                if (kDebugMode) {
                  print("finished hiding, so $isLoading");
                }
              }
            },
          );
          final isLoggedIn = ref.watch(isLoggedInProvider);
          if (isLoggedIn) {
            return const HomePageView();
          } else {
            return const NewLoginView();
          }
        },
      ),
    );
  }
}
