import 'package:flutter/foundation.dart' show immutable;
import 'package:itsula/views/components/dialogs/alert_dialog_model.dart';
import 'package:itsula/views/constants/strings.dart';

@immutable
class DeleteDialog extends AlertDialogModel<bool> {
  const DeleteDialog({required String titleOfObjectToDelete})
      : super(
          title: '${Strings.delete} $titleOfObjectToDelete?',
          message:
              '${Strings.areYouSureYouWantToDeleteThis} $titleOfObjectToDelete?',
          buttons: const {
            Strings.cancel: false,
            Strings.delete: true,
          },
        );
}
