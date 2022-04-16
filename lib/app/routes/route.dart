import 'package:flutter/material.dart';
import 'package:sulai/app/views/home/home.dart';
import 'package:sulai/app/views/notification/notification.dart';

import '../views/auth/login.dart';
import '../views/auth/register.dart';
import '../views/order/checkout.dart';
import '../views/order/order.dart';
import '../views/product/product.dart';

class Routes {
  Routes._();

  static const home = "/home";
  static const login = "/login";
  static const register = "/register";
  static const product = "/product";
  static const booking = "/booking";
  static const checkout = "/checkout";
  static const notification = "/notification";

  static final data = <String, WidgetBuilder>{
    home: (_) => const HomePage(),
    login: (_) => const LoginPage(),
    register: (_) => const RegisterPage(),
    product: (_) => const ProductPage(),
    booking: (_) => const OrderPage(),
    checkout: (_) => const CheckoutPage(),
    notification: (_) => const NotificationPage(),
  };
}
