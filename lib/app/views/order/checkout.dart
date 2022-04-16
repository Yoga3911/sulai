import 'package:flutter/material.dart';
import 'package:sulai/app/widgets/app_bar.dart';
import 'package:sulai/app/widgets/main_style.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return const MainStyle(
      widget: [
        CustomAppBar(),
      ],
    );
  }
}
