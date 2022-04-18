import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sulai/app/view_model/order_provider.dart';

class OrderFilter extends StatelessWidget {
  const OrderFilter({Key? key, required this.label, required this.color, required this.statusId})
      : super(key: key);

  final String label;
  final Color color;
  final String statusId;

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<OrderProvider>(context, listen: false);
    return Flexible(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
        height: 35,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => order.getAll("", statusId: statusId),
            borderRadius: BorderRadius.circular(5),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}