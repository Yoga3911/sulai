import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sulai/app/view_model/user_provider.dart';
import 'package:sulai/app/views/home/home.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

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
        return const HomePage();
      }),
    );
  }
}
