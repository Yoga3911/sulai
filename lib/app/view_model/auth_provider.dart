import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sulai/app/services/email.dart';
import 'package:sulai/app/services/social.dart';

import '../routes/route.dart';
import 'user_provider.dart';

class AuthProvider with ChangeNotifier {
  final String _blank =
      "https://firebasestorage.googleapis.com/v0/b/sulai-a79f0.appspot.com/o/profile.png?alt=media&token=a1d307af-90c1-4199-8703-28e43579bb7e";

  void register(
      {BuildContext? context, String? name, String? email, String? password}) {
    final _user = Provider.of<UserProvider>(context!, listen: false);
    EmailService().signUp(email: email!, password: password!).then(
      (user) async {
        _user.insertUser(
          email: email,
          password: password,
          img: _blank,
          name: name,
          provider: "email",
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
      String password = "123456"}) {
    final _user = Provider.of<UserProvider>(context!, listen: false);
    if (provider == "email") {
      EmailService social = EmailService();
      social.signIn(email: email, password: password).then(
        (user) async {
          await _user.getUserByEmail(email: email);

          Navigator.pushReplacementNamed(context, Routes.home).then(
            (_) async {
              final pref = await SharedPreferences.getInstance();
              pref.setString("social", provider!);
              Navigator.pop(context);
            },
          );
        },
      );
    } else if (provider != "email") {
      social!.signIn().then(
        (user) async {
          await _user.insertUser(
            name: user.user!.displayName,
            email: user.user!.email,
            img: user.user!.photoURL,
            provider: provider,
          );

          await _user.getUserByEmail(email: user.user!.email!);
          
          Navigator.pushReplacementNamed(context, Routes.home).then(
            (_) async {
              final pref = await SharedPreferences.getInstance();
              pref.setString("social", provider!);
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
