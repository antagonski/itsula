import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/auth/models/auth_state.dart';
import 'package:itsula/state/auth/notifiers/auth_state_notifier.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (_) => AuthStateNotifier(),
);
