import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sulai/app/services/email.dart';

import '../constant/collection.dart';
import '../models/login_model.dart';
import '../models/user_model.dart';
import '../routes/route.dart';
import '../services/facebook.dart';
import '../services/google.dart';
import 'user_provider.dart';

enum Social { google, facebook, email }

class LoginProvider with ChangeNotifier {
  final TextEditingController emailLogin = TextEditingController();
  final TextEditingController passLogin = TextEditingController();

  final TextEditingController nameRegis = TextEditingController();
  final TextEditingController emailRegis = TextEditingController();
  final TextEditingController pass1Regis = TextEditingController();
  final TextEditingController pass2Regis = TextEditingController();

  LoginModel loginValue() => LoginModel(
        email: emailLogin.text,
        password: passLogin.text,
      );

  Map<String, String> registerValue() => {
        "name": nameRegis.text,
        "email": emailRegis.text,
        "password1": pass1Regis.text,
        "password2": pass2Regis.text,
      };

  final String _blank =
      "https://firebasestorage.googleapis.com/v0/b/sulai-a79f0.appspot.com/o/profile.png?alt=media&token=a1d307af-90c1-4199-8703-28e43579bb7e";

  Future<void> signUp(BuildContext context,
      {String? name, String? email, String? password}) async {
    final login = Provider.of<LoginProvider>(context, listen: false);
    EmailService().signUp(email: email!, password: password!).then(
      (user) async {
        final account =
            await MyCollection.user.where("email", isEqualTo: email).get();
        if (account.docs.isEmpty) {
          MyCollection.user.add(
            UserModel(
              email: email,
              id: "",
              imageUrl: _blank,
              name: name!,
              roleId: "1",
              provider: "Email",
              createAt: DateTime.now(),
              updateAt: DateTime.now(),
            ).toJson(),
          );
          final data =
              await MyCollection.user.where("email", isEqualTo: email).get();
          MyCollection.user.doc(data.docs.first.id).update(
            {
              "id": data.docs.first.id,
            },
          );
        }
        login.nameRegis.clear();
        login.emailRegis.clear();
        login.pass1Regis.clear();
        login.pass2Regis.clear();
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.login,
          (route) => false,
        ).then((_) => Navigator.pop(context));
      },
    );
  }

  Future<void> signIn(
      BuildContext context, UserProvider _user, Social social) async {
    final pref = await SharedPreferences.getInstance();
    final login = Provider.of<LoginProvider>(context, listen: false);
    switch (social) {
      case Social.email:
        EmailService()
            .signIn(
                email: login.emailLogin.text, password: login.passLogin.text)
            .then(
          (user) async {
            pref.setString("social", "email");
            _user.setUser = user.user!;
            final account = await MyCollection.user
                .where("email", isEqualTo: user.user!.email)
                .get();
            if (account.docs.isEmpty) {
              MyCollection.user.add(
                UserModel(
                  email: user.user!.email!,
                  id: "",
                  imageUrl: user.user!.photoURL ?? _blank,
                  name: user.user!.displayName!,
                  roleId: "1",
                  provider: "Email",
                  createAt: DateTime.now(),
                  updateAt: DateTime.now(),
                ).toJson(),
              );
              final data = await MyCollection.user
                  .where("email", isEqualTo: user.user!.email)
                  .get();
              MyCollection.user.doc(data.docs.first.id).update(
                {
                  "id": data.docs.first.id,
                },
              );
            }
            login.emailLogin.clear();
            login.passLogin.clear();
            Navigator.pushReplacementNamed(context, Routes.home)
                .then((_) => Navigator.pop(context));
          },
        );
        break;
      case Social.google:
        GoogleService().signIn().then(
          (user) async {
            pref.setString("social", "google");
            _user.setUser = user.user!;
            final account = await MyCollection.user
                .where("email", isEqualTo: user.user!.email)
                .get();
            if (account.docs.isEmpty) {
              MyCollection.user.add(
                UserModel(
                  email: user.user!.email!,
                  id: "",
                  imageUrl: user.user!.photoURL ?? _blank,
                  name: user.user!.displayName!,
                  roleId: "1",
                  provider: "Google",
                  createAt: DateTime.now(),
                  updateAt: DateTime.now(),
                ).toJson(),
              );
              final data = await MyCollection.user
                  .where("email", isEqualTo: user.user!.email)
                  .get();
              MyCollection.user.doc(data.docs.first.id).update(
                {
                  "id": data.docs.first.id,
                },
              );
            }
            Navigator.pushReplacementNamed(context, Routes.home)
                .then((_) => Navigator.pop(context));
          },
        );
        break;
      case Social.facebook:
        FacebookService().signIn().then(
          (user) async {
            pref.setString("social", "facebook");
            _user.setUser = user.user!;
            final account = await MyCollection.user
                .where("email", isEqualTo: user.user!.email)
                .get();
            if (account.docs.isEmpty) {
              MyCollection.user.add(
                UserModel(
                  email: user.user!.email!,
                  id: "",
                  imageUrl: user.user!.photoURL ?? _blank,
                  name: user.user!.displayName!,
                  roleId: "1",
                  provider: "Facebook",
                  createAt: DateTime.now(),
                  updateAt: DateTime.now(),
                ).toJson(),
              );
              final data = await MyCollection.user
                  .where("email", isEqualTo: user.user!.email)
                  .get();
              MyCollection.user.doc(data.docs.first.id).update(
                {
                  "id": data.docs.first.id,
                },
              );
            }
            Navigator.pushReplacementNamed(context, Routes.home)
                .then((_) => Navigator.pop(context));
          },
        );
        break;
    }
  }
}
