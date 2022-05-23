import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  OrderModel({
    required this.id,
    required this.orderId,
    required this.statusId,
    required this.userId,
    required this.productId,
    required this.orderDate,
    required this.quantity,
    required this.sizeId,
    required this.paymentId,
    required this.address,
    required this.invoiceId,
    required this.invoiceUrl,
    required this.postalCode,
  });

  final String id;
  final String orderId;
  final String statusId;
  final String userId;
  final String productId;
  final String paymentId;
  final DateTime orderDate;
  final int quantity;
  final String sizeId;
  final String address;
  final String invoiceId;
  final String invoiceUrl;
  final String postalCode;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        orderId: json["order_id"],
        statusId: json["status_id"],
        userId: json["user_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        sizeId: json["size_id"],
        paymentId: json["payment_id"],
        address: json["address"],
        orderDate: (json["order_date"] as Timestamp).toDate(),
        postalCode: json["postal_code"],
        invoiceId: json["invoice_id"],
        invoiceUrl: json["invoice_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "status_id": statusId,
        "user_id": userId,
        "product_id": productId,
        "quantity": quantity,
        "size_id": sizeId,
        "payment_id": paymentId,
        "address": address,
        "postal_code": postalCode,
        "invoice_id": invoiceId,
        "invoice_url": invoiceUrl,
        "order_date": orderDate,
      };
}
