import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  OrderModel({
    required this.orderId,
    required this.statusId,
    required this.userId,
    required this.title,
    required this.subtitle,
    required this.orderDate,
  });

  final String orderId;
  final String statusId;
  final String userId;
  final String title;
  final String subtitle;
  final DateTime orderDate;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        orderId: json["order_id"],
        statusId: json["status_id"],
        userId: json["user_id"],
        title: json["title"],
        subtitle: json["subtitle"],
        orderDate: (json["order_date"] as Timestamp).toDate(),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "status_id": statusId,
        "user_id": userId,
        "title": title,
        "subtitle": subtitle,
        "order_date": orderDate,
      };
}
