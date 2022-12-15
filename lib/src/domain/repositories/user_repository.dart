import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common_authentication/src/constants/firebase_collections.dart';
import 'package:common_authentication/src/models/user_data.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class UserRepository {
  final _userCollection = _firestore.collection(
    CollectionName.users.name,
  );

  Future<void> createUser({required UserData user}) async {
    DocumentSnapshot userSnapshot = await _userCollection.doc(user.uid).get();
    if (userSnapshot.exists) {
      log('user already exist');
      return;
    }
    return _userCollection.doc(user.uid).set(user.toJson());
  }
}
