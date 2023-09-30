class HomePageState {
  final int index;
  final bool isSideMenuHidden;

  HomePageState({
    required this.index,
    required this.isSideMenuHidden,
  });

  const HomePageState.initial()
      : index = 0,
        isSideMenuHidden = true;

  HomePageState copyWith({
    int? index,
    bool? isSideMenuHidden,
  }) =>
      HomePageState(
        index: index ?? this.index,
        isSideMenuHidden: isSideMenuHidden ?? this.isSideMenuHidden,
      );
}
