import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/blog_settings/models/blog_setting.dart';
import 'package:itsula/state/blog_settings/notifiers/blog_settings_notifier.dart';

final blogSettingProvider =
    StateNotifierProvider<BlogSettingsNotifier, Map<BlogSetting, bool>>(
  (ref) => BlogSettingsNotifier(),
);
