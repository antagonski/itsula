import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/homepage/models/homepage_state.dart';
import 'package:itsula/state/homepage/notifiers/homepage_state_notifier.dart';

final homePageStateProvider =
    StateNotifierProvider<HomePageStateNotifier, HomePageState>(
  (_) => HomePageStateNotifier(),
);
