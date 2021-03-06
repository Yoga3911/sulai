import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sulai/app/view_model/dropdown.dart';
import 'package:sulai/app/view_model/location.dart';
import 'package:sulai/app/view_model/order_provider.dart';
import 'package:sulai/app/view_model/product_provider.dart';
import 'package:sulai/app/view_model/ulasan_provider.dart';

import 'auth_provider.dart';
import 'notification.dart';
import 'user_provider.dart';

final List<SingleChildWidget> providerData = [
  ChangeNotifierProvider(create: (_) => UserProvider()),
  ChangeNotifierProvider(create: (_) => AuthProvider()),
  ChangeNotifierProvider(create: (_) => ProductProvider()),
  ChangeNotifierProvider(create: (_) => NotificationProvider()),
  ChangeNotifierProvider(create: (_) => DropDownNotifier()),
  ChangeNotifierProvider(create: (_) => DropDownNotifier2()),
  ChangeNotifierProvider(create: (_) => OrderProvider()),
  ChangeNotifierProvider(create: (_) => MyLocation()),
  ChangeNotifierProvider(create: (_) => UlasanProvider()),
];
