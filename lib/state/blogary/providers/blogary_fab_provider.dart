import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/blogary/notifiers/blogary_fab_notifier.dart';

final blogaryFabProvider = StateNotifierProvider<BlogaryFabNotifier, bool>(
  (ref) => BlogaryFabNotifier(),
);
