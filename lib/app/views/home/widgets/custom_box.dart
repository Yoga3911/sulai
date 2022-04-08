import 'package:flutter/material.dart';

import '../../../constant/color.dart';

class CustomBox extends StatelessWidget {
  const CustomBox({Key? key, required this.icon, required this.label}) : super(key: key);
  final String icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.1,
      width: size.height * 0.1,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            blurRadius: 2,
            offset: Offset(4, 4),
            spreadRadius: 1,
            color: Color.fromARGB(255, 209, 209, 209),
          )
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: size.height * 0.09,
            width: size.height * 0.09,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: MyColor.linerGradient,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                icon,
                color: Colors.white,
              ),
              Text(
                label,
                style: const TextStyle(color: Colors.white),
              )
            ],
          )
        ],
      ),
    );
  }
}
