import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/homepage/models/homepage_state.dart';

class HomePageStateNotifier extends StateNotifier<HomePageState> {
  HomePageStateNotifier()
      : super(
          const HomePageState.initial(),
        );

  bool getIsSideMenuHidden() => state.isSideMenuHidden;

  int geCurrentIndex() => state.index;

  void reset() {
    state = const HomePageState.initial();
  }

  void onIndexChange(
    int index,
  ) {
    state = state.copyWith(
      index: index,
    );
  }

  void onSideMenuOpenOrHiddenChange() {
    state = state.copyWith(
      isSideMenuHidden: !state.isSideMenuHidden,
    );
  }
}
