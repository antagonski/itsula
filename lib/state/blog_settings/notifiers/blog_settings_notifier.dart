import 'dart:collection';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/blog_settings/models/blog_setting.dart';

class BlogSettingsNotifier extends StateNotifier<Map<BlogSetting, bool>> {
  BlogSettingsNotifier()
      : super(
          UnmodifiableMapView(
            {
              for (final setting in BlogSetting.values) setting: true,
            },
          ),
        );

  void setSetting(
    BlogSetting setting,
    bool value,
  ) {
    final existingValue = state[setting];
    if (existingValue == null || existingValue == value) {
      return;
    }
    state = Map.unmodifiable(
      Map.from(state)..[setting] = value,
    );
  }
}
