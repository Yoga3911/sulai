import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sulai/app/routes/route.dart';
import 'package:sulai/app/services/google.dart';
import 'package:sulai/app/view_model/user_provider.dart';

import '../../constant/color.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const blank =
        "https://firebasestorage.googleapis.com/v0/b/sulai-a79f0.appspot.com/o/profile.png?alt=media&token=a1d307af-90c1-4199-8703-28e43579bb7e";
    final user = Provider.of<UserProvider>(context).getUser;
    final size = MediaQuery.of(context).size;
    return SafeArea(
      
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(gradient: MyColor.linerGradient),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.photoURL ?? blank),
                      radius: 50,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      user.displayName ?? "Blank",
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment(-0.8, -0.8),
              child: Container(
                height: size.height * 0.05,
                width: size.height * 0.05,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white
                ),
                child: Icon(Icons.menu),
              ),
            )
          ],
        ),
      ),
    );
  }
}
