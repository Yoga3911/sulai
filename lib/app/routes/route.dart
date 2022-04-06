import 'package:flutter/material.dart';
import 'package:sulai/app/views/home/home.dart';

import '../views/auth/login.dart';
import '../views/auth/register.dart';

class Routes {
  Routes._();

  static const home = "/home";
  static const login = "/login";
  static const register = "/register";

  static final data = <String, WidgetBuilder>{
    home: (_) => const HomePage(),
    login: (_) => const LoginPage(),
    register: (_) => const RegisterPage(),
  };
}
