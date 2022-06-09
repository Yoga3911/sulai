import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  OrderModel({
    required this.id,
    required this.orderId,
    required this.statusId,
    required this.processId,
    required this.userId,
    required this.productId,
    required this.orderDate,
    required this.quantity,
    required this.chargeId,
    required this.sizeId,
    required this.paymentId,
    required this.address,
    required this.checkoutUrl,
    required this.postalCode,
  });

  final String id;
  final String orderId;
  final String statusId;
  final String processId;
  final String userId;
  final String productId;
  final String paymentId;
  final DateTime orderDate;
  final int quantity;
  final String chargeId;
  final String sizeId;
  final String address;
  final String checkoutUrl;
  final String postalCode;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        orderId: json["order_id"],
        statusId: json["status_id"],
        processId: json["process_id"],
        userId: json["user_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        sizeId: json["size_id"],
        chargeId: json["charge_id"],
        paymentId: json["payment_id"],
        address: json["address"],
        orderDate: (json["order_date"] as Timestamp).toDate(),
        postalCode: json["postal_code"],
        checkoutUrl: json["checkout_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "status_id": statusId,
        "process_id": processId,
        "user_id": userId,
        "product_id": productId,
        "quantity": quantity,
        "size_id": sizeId,
        "payment_id": paymentId,
        "charge_id": chargeId,
        "address": address,
        "postal_code": postalCode,
        "checkout_url": checkoutUrl,
        "order_date": orderDate,
      };
}
