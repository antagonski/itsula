import 'package:hooks_riverpod/hooks_riverpod.dart';

class BlogaryFabNotifier extends StateNotifier<bool> {
  BlogaryFabNotifier() : super(false);
  bool get value => state;
  void changeHideShowStatus() {
    state = !state;
  }
}
