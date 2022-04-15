import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sulai/app/routes/route.dart';
import 'package:sulai/app/view_model/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providerData,
      child: MaterialApp(
        initialRoute: Routes.login,
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
