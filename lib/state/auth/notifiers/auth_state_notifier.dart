import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/auth/backend/authenticator.dart';
import 'package:itsula/state/auth/models/auth_result.dart';
import 'package:itsula/state/auth/models/auth_state.dart';
import 'package:itsula/state/blogary/blogs/typedefs/user_id.dart';
import 'package:itsula/state/user_info/backend/user_info_storage.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  final _userInfoStorage = const UserInfoStorage();
  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
        result: AuthResult.success,
        isLoading: false,
        userId: _authenticator.userId,
      );
    }
  }

  // The authenticator simply calls functions, it has no state,
  // Just returns the results, does not contain results,
  // A state notifier contains the results and can check
  // Whether we are already logged in or not.
  Future<void> logOut() async {
    state = state.copiedWithIsLoading(true);
    await _authenticator.logOut();
    state = const AuthState.unknown();
  }

  Future<void> logInWithGoogle() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(
        userId: userId,
      );
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );
  }

  Future<void> saveUserInfo({required UserId userId}) async =>
      _userInfoStorage.saveUserInfo(
        userId: userId,
        displayName: _authenticator.displayName,
        email: _authenticator.email,
      );

  Future<void> logInWithFacebook() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithFacebook();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(
        userId: userId,
      );
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );
  }
}
