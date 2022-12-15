import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:json_annotation/json_annotation.dart';

part 'user_data.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class UserData {
  const UserData({
    required this.uid,
    this.email,
    this.photoUrl,
    this.displayName,
  });

  UserData.fromFirebaseUser({
    required User user,
  })  : uid = user.uid,
        email = user.email,
        photoUrl = user.photoURL,
        displayName = user.displayName;

  final String uid;
  final String? email;
  final String? photoUrl;
  final String? displayName;

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
