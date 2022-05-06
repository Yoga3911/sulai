import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/collection.dart';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel get getUser => _user!;

  set setUser(UserModel userCredential) {
    _user = userCredential;
  }

  // Future<void> getCredential({String? id}) async {
  //   final data = await MyCollection.user.doc(id).get();
  // }

  Future<void> getUserByEmail({String? email}) async {
    final data = await MyCollection.user.where("email", isEqualTo: email).get();
    final pref = await SharedPreferences.getInstance();
    pref.setString("id", data.docs.first.id);
    setUser =
        UserModel.fromJson(data.docs.first.data() as Map<String, dynamic>);
  }

  Future<void> getUserById() async {
    final pref = await SharedPreferences.getInstance();
    final data = await MyCollection.user.doc(pref.getString("id")).get();
    setUser = UserModel.fromJson(data.data() as Map<String, dynamic>);
  }

  Future<UserModel> getById({String? userId}) async {
    final data = await MyCollection.user.doc(userId).get();
    return UserModel.fromJson(data.data() as Map<String, dynamic>);
  }

  Future<void> insertUser(
      {String? email,
      String? password,
      String? img,
      String? name,
      String? provider}) async {
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

  Future<void> changeProfile({
    String? img,
    String? name,
    String? userId,
  }) async {
    MyCollection.user.doc(userId).update(
      {
        "name": name,
        "image_url": img,
      },
    );
    await getUserById();
  }
}
