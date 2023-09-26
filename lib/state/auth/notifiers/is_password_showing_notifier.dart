import 'package:hooks_riverpod/hooks_riverpod.dart';

class IsPasswordShowingNotifier extends StateNotifier<bool> {
  IsPasswordShowingNotifier() : super(true);
  bool updatePasswordShowingStatus() => state = !state;
  bool get value => state;
}
