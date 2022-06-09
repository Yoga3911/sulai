import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sulai/app/services/social.dart';

class EmailService extends SocialService {
  Future<dynamic> signUp(
      {String email = "email", String password = "password"}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (FirebaseAuth.instance.currentUser != null &&
          !FirebaseAuth.instance.currentUser!.emailVerified) {
        log("Verif email");
        await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      }

      log("Register success");

      return "";
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return "Email telah terdaftar, silahkan gunakan email lain";
      } else if (e.code == "weak-password") {
        return "Password terlalu lemah";
      }
    }
  }

  @override
  Future<dynamic> signIn(
      {String email = "email@gmail.com", String password = "password"}) async {
    try {
      final UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      log("Login success");
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        return "User tidak ditemukan";
      } else if (e.code == "wrong-password") {
        return "Password salah";
      }
    }
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    log("Success log out from email account");
  }
}
