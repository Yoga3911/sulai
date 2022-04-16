import 'package:flutter/material.dart';

import '../constant/color.dart';
import 'glow.dart';

class MainStyle extends StatelessWidget {
  const MainStyle({Key? key, required this.widget}) : super(key: key);
  final List<Widget> widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFDEDBD4),
      child: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                gradient: MyColor.linerGradient,
              ),
              child: ScrollConfiguration(
                behavior: NoGlow(),
                child: ListView(
                  children: widget,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
