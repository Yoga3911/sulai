import 'dart:developer';

import 'package:flutter/material.dart';

import '../constant/collection.dart';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel get getUser => _user!;

  set setUser(UserModel userCredential) {
    _user = userCredential;
    notifyListeners();
  }

  Future<void> getUserByEmail(String email) async {
    final data = await MyCollection.user.where("email", isEqualTo: email).get();
    inspect(data);
    setUser = UserModel.fromJson(data.docs.first.data() as Map<String, dynamic>);
  }
}
