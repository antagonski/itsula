import 'package:flutter/foundation.dart' show immutable;
import 'package:itsula/views/components/dialogs/alert_dialog_model.dart';
import 'package:itsula/views/constants/strings.dart';

@immutable
class LogoutDialog extends AlertDialogModel<bool> {
  const LogoutDialog()
      : super(
          title: Strings.logout,
          message: Strings.areYouSureThatYouWantToLogOut,
          buttons: const {
            Strings.cancel: false,
            Strings.logout: true,
          },
        );
}
