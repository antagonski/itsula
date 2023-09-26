import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/auth/notifiers/is_password_showing_notifier.dart';

final isPasswordShowingProvider =
    StateNotifierProvider<IsPasswordShowingNotifier, bool>(
  (ref) => IsPasswordShowingNotifier(),
);
