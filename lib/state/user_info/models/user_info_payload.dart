import 'dart:collection' show MapView;

import 'package:flutter/foundation.dart' show immutable;
import 'package:itsula/state/constants/firebase_field_name.dart';
import 'package:itsula/state/blogary/blogs/typedefs/user_id.dart';

@immutable
class UserInfoPayLoad extends MapView<String, String> {
  UserInfoPayLoad({
    required UserId userId,
    required String? displayName,
    required String? email,
  }) : super(
          {
            FirebaseFieldName.userId: userId,
            FirebaseFieldName.displayName: displayName ?? '',
            FirebaseFieldName.email: email ?? '',
          },
        );
}
