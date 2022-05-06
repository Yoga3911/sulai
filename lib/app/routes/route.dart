import 'package:flutter/material.dart';
import 'package:sulai/app/views/home/home.dart';
import 'package:sulai/app/views/home/main_page.dart';
import 'package:sulai/app/views/maps/maps.dart';
import 'package:sulai/app/views/media/media.dart';
import 'package:sulai/app/views/notification/notification.dart';
import 'package:sulai/app/views/order/history.dart';
import 'package:sulai/app/views/product/update_product.dart';
import 'package:sulai/app/views/profile/profile.dart';

import '../views/auth/login.dart';
import '../views/auth/register.dart';
import '../views/order/checkout.dart';
import '../views/order/order.dart';
import '../views/product/product.dart';
import '../views/shop/shop.dart';

class Routes {
  Routes._();

  static const main = "/main";
  static const home = "/home";
  static const login = "/login";
  static const register = "/register";
  static const product = "/product";
  static const order = "/order";
  static const orderData = "/order/data";
  static const checkout = "/checkout";
  static const notification = "/notification";
  static const profile = "/profile";
  static const shop = "/shop";
  static const media = "/media";
  static const updateProduct = "/updateProduct";
  static const maps = "/maps";

  static final data = <String, WidgetBuilder>{
    main: (_) => const MainPage(),
    home: (_) => const HomePage(),
    login: (_) => const LoginPage(),
    register: (_) => const RegisterPage(),
    product: (_) => const ProductPage(),
    order: (_) => const OrderPage(),
    orderData: (_) => const OrderData(),
    checkout: (_) => const CheckoutPage(),
    notification: (_) => const NotificationPage(),
    profile: (_) => const ProfilePage(),
    shop: (_) => const ShopPage(),
    media: (_) => const MediaPage(),
    updateProduct: (_) => const UpdateProduct(),
    maps: (_) => const MyMaps(),
  };
}
