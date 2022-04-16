import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sulai/app/view_model/product_provider.dart';

import 'auth_provider.dart';
import 'notification.dart';
import 'user_provider.dart';

final List<SingleChildWidget> providerData = [
  ChangeNotifierProvider(create: (_) => UserProvider()),
  ChangeNotifierProvider(create: (_) => AuthProvider()),
  ChangeNotifierProvider(create: (_) => ProductProvider()),
  ChangeNotifierProvider(create: (_) => NotificationProvider()),
];
