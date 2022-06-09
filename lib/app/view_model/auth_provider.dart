import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sulai/app/constant/collection.dart';
import 'package:sulai/app/services/email.dart';
import 'package:sulai/app/services/social.dart';

import '../routes/route.dart';
import 'user_provider.dart';

class AuthProvider with ChangeNotifier {
  final String _blank =
      "https://firebasestorage.googleapis.com/v0/b/sulai-a79f0.appspot.com/o/profile.png?alt=media&token=a1d307af-90c1-4199-8703-28e43579bb7e";

  void register(
      {BuildContext? context,
      String? name,
      String? email,
      String? password}) async {
    final _user = Provider.of<UserProvider>(context!, listen: false);
    EmailService().signUp(email: email!, password: password!).then(
      (user) async {
        if (user.toString().length > 1) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(user),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }
        _user.insertUser(
            email: email,
            fcmToken: "-",
            password: password,
            img: _blank,
            name: name,
            provider: "email",
            isActive: false);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Register berhasil"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.login,
          (route) => false,
        ).then((_) => Navigator.pop(context));
      },
    );
  }

  void login(
      {BuildContext? context,
      SocialService? social,
      String? provider,
      String email = "blank@gmail.com",
      String password = "123456"}) async {
    final _user = Provider.of<UserProvider>(context!, listen: false);
    final pref = await SharedPreferences.getInstance();
    if (provider == "email") {
      EmailService social = EmailService();
      social.signIn(email: email, password: password).then(
        (user) async {
          if (user.runtimeType == UserCredential) {
            final data =
                await MyCollection.user.where("email", isEqualTo: email).get();
            MyCollection.user
                .doc(data.docs.first.id)
                .update({"fcm_token": pref.getString("fcmToken")});
            pref.setString("id", data.docs.first.id);
            pref.setString("social", provider!);
            Navigator.pushReplacementNamed(context, Routes.main).then(
              (_) async {
                Navigator.pop(context);
              },
            );
            return;
          }
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                user.toString(),
              ),
              backgroundColor: Colors.red,
            ),
          );
        },
      );
    } else if (provider != "email") {
      social!.signIn().then(
        (user) async {
          await _user.insertUser(
            fcmToken: "-",
            name: user.user!.displayName,
            email: user.user!.email,
            img: user.user!.photoURL,
            provider: provider,
            isActive: false,
          );
          await _user.getUserByEmail(email: user.user!.email);

          pref.setString("social", provider!);
          Navigator.pushReplacementNamed(context, Routes.main).then(
            (_) async {
              Navigator.pop(context);
            },
          );
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
