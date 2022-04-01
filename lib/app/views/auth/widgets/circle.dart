import 'package:flutter/material.dart';

class PositionedCircle extends StatelessWidget {
  const PositionedCircle({Key? key, required this.boxShadow, required this.top, required this.color}) : super(key: key);

  final List<BoxShadow> boxShadow;
  final double top;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Transform.scale(
      scale: 3,
      child: Container(
        height: size.height,
        width: size.height,
        decoration: BoxDecoration(
          boxShadow: boxShadow,
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
