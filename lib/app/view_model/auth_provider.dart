import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sulai/app/services/email.dart';
import 'package:sulai/app/services/social.dart';

import '../constant/collection.dart';
import '../models/login_model.dart';
import '../models/user_model.dart';
import '../routes/route.dart';
import 'user_provider.dart';

enum Social { google, facebook, email }

class AuthProvider with ChangeNotifier {
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

  void register(BuildContext context,
      {String? name, String? email, String? password}) {
    final login = Provider.of<AuthProvider>(context, listen: false);
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

  void login(BuildContext context, UserProvider _user, SocialService social,
      {String email = "blank@gmail.com", String password = "123456"}) {
    const String blank =
        "https://firebasestorage.googleapis.com/v0/b/breadify-a4a04.appspot.com/o/user.png?alt=media&token=30e27068-d2ff-4dcb-b734-c818c49863fd";
    if (email != "blank@gmail.com") {
      EmailService social = EmailService();
      social.signIn(email: email, password: password).then(
        (user) async {
          final pref = await SharedPreferences.getInstance();
          pref.setString("social", social.name);

          final account = await MyCollection.user
              .where("email", isEqualTo: user.user!.email)
              .get();
          if (account.docs.isEmpty) {
            MyCollection.user.add(
              UserModel(
                email: user.user!.email!,
                id: "",
                imageUrl: user.user!.photoURL ?? blank,
                name: user.user!.displayName!,
                roleId: "1",
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
          final data = await MyCollection.user
              .where("email", isEqualTo: user.user!.email)
              .get();

          _user.setUser = UserModel.fromJson(
              data.docs.first.data() as Map<String, dynamic>);
          Navigator.pushReplacementNamed(context, Routes.home)
              .then((_) => Navigator.pop(context));
        },
      );
    } else if (email == "blank@gmail.com") {
      social.signIn().then(
        (user) async {
          final pref = await SharedPreferences.getInstance();
          pref.setString("social", social.name);

          final account = await MyCollection.user
              .where("email", isEqualTo: user.user!.email)
              .get();
          if (account.docs.isEmpty) {
            MyCollection.user.add(
              UserModel(
                email: user.user!.email!,
                id: "",
                imageUrl: user.user!.photoURL ?? blank,
                name: user.user!.displayName!,
                roleId: "1",
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
          final data = await MyCollection.user
              .where("email", isEqualTo: user.user!.email)
              .get();

          _user.setUser = UserModel.fromJson(
              data.docs.first.data() as Map<String, dynamic>);
          Navigator.pushReplacementNamed(context, Routes.home)
              .then((_) => Navigator.pop(context));
        },
      );
    }
  }

  void logout(BuildContext context, SocialService social) {
    social.signOut().then(
      (value) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.login,
          (route) => false,
        ).then(
          (_) => Navigator.pop(context),
        );
      },
    );
  }
}
