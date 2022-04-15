import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constant/collection.dart';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel get getUser => _user!;

  set setUser(UserModel userCredential) {
    _user = userCredential;
  }

  Future<void> getUserByEmail({String? email}) async {
    final data = await MyCollection.user.where("email", isEqualTo: email).get();
    setUser =
        UserModel.fromJson(data.docs.first.data() as Map<String, dynamic>);
  }

  Future<void> insertUser(
      {String? email, String? password, String? img, String? name, String? provider}) async {
    QuerySnapshot<Object?> account =
        await MyCollection.user.where("email", isEqualTo: email).get();
    final collection = MyCollection.user.doc();
    if (account.docs.isEmpty) {
      await collection.set(
        UserModel(
          id: collection.id,
          email: email!,
          password: password ?? "-",
          imageUrl: img!,
          name: name!,
          roleId: "1",
          provider: provider!,
          createAt: DateTime.now(),
          updateAt: DateTime.now(),
        ).toJson(),
      );
    }
  }
}
