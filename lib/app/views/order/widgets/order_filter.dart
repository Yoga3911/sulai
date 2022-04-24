import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sulai/app/view_model/order_provider.dart';

import '../../../view_model/user_provider.dart';

class OrderFilter extends StatelessWidget {
  const OrderFilter({Key? key, required this.label, required this.color, required this.statusId})
      : super(key: key);

  final String label;
  final Color color;
  final String statusId;

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<OrderProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context, listen: false);
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
      height: 35,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => order.getAll(user.getUser.id, statusId: statusId),
          borderRadius: BorderRadius.circular(5),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
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
