import 'package:flutter/material.dart';
import 'package:sulai/app/constant/color.dart';
import 'package:sulai/app/widgets/app_bar.dart';
import 'package:sulai/app/widgets/glow.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFDEDBD4),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(gradient: MyColor.linerGradient),
            child: ScrollConfiguration(behavior: NoGlow(), child: ListView(
              children: [
                Column(
                  children: const [
                    CustomAppBar()
                  ],
                )
              ],
            )),
          ),
        ),
      ),
    );
  }
}
