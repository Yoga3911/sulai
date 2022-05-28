import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sulai/app/view_model/user_provider.dart';
import 'package:sulai/app/views/home/home.dart';
import 'package:sulai/app/views/pin/pin.dart';

import '../../constant/collection.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    final pref = await SharedPreferences.getInstance();
    final user = MyCollection.user.doc(pref.getString("id"));

    if (state == AppLifecycleState.resumed) {
      user.update({
        "isActive": true,
      });
    } else if (state == AppLifecycleState.paused) {
      user.update({
        "isActive": false,
      });
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      body: FutureBuilder<void>(
          future: user.getUserById(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox();
            }

            return (user.getUser.pin == "-")
                ? const PinPage()
                : const HomePage();
          }),
    );
  }
}
