import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sulai/app/routes/route.dart';
import 'package:sulai/app/view_model/provider.dart';

void selectRoute() async {
  final pref = await SharedPreferences.getInstance();
  if (pref.getString("id") != null) {
    runApp(const MyApp(route: Routes.main));
  } else if (pref.getString("id") == null) {
    runApp(const MyApp(route: Routes.login));
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initializeDateFormatting("in_ID", "");
  selectRoute();
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
