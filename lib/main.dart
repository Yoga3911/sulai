
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sulai/app/routes/route.dart';
import 'package:sulai/app/view_model/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // ignore: avoid_print
  print("Handling a background message");
}

void selectRoute(String fcmToken) async {
  final pref = await SharedPreferences.getInstance();
  pref.setString("fcmToken", fcmToken);
  if (pref.getString("id") != null) {
    runApp(const MyApp(route: Routes.main));
  } else if (pref.getString("id") == null) {
    runApp(const MyApp(route: Routes.login));
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final token = await FirebaseMessaging.instance.getToken();
  initializeDateFormatting("in_ID", "");
  selectRoute(token!);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.route}) : super(key: key);

  final String route;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providerData,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: route,
        routes: Routes.data,
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: Color.fromARGB(255, 255, 219, 134),
            onSurface: Colors.black,
          ),
          fontFamily: "Poppins",
        ),
      ),
    );
  }
}
