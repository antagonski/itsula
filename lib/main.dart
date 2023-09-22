import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/firebase_options.dart';
import 'package:itsula/state/auth/providers/auth_state_provider.dart';

import 'dart:developer' as devtools show log;

import 'package:itsula/state/auth/providers/is_logged_in_provider.dart';
import 'package:itsula/views/components/random/dummy_page.dart';

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
          final isLoggedIn = ref.watch(isLoggedInProvider);
          if (isLoggedIn) {
            return const MainView();
          } else {
            return const LoginView();
          }
        },
      ),
    );
  }
}

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login View'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: TextButton(
              onPressed: ref.read(authStateProvider.notifier).logInWithGoogle,
              child: const Text("Google"),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: ref.read(authStateProvider.notifier).logInWithFacebook,
              child: const Text("FB"),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push<void>(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const DummyPage(),
                  ),
                );
              },
              child: const Text("DUMMY PAGE"),
            ),
          ),
        ],
      ),
    );
  }
}

class MainView extends ConsumerWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Main View'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Consumer(
              builder: (_, ref, child) {
                return TextButton(
                  onPressed: () async {
                    ref.read(authStateProvider.notifier).logOut();
                  },
                  child: const Text("Logout"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
