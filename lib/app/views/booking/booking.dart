import 'package:flutter/material.dart';
import 'package:sulai/app/constant/color.dart';
import 'package:sulai/app/widgets/app_bar.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: MyColor.linerGradient,
          ),
          child: Column(
            children: const [CustomAppBar()],
          ),
        ),
      ),
    );
  }
}
