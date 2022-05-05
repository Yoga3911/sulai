import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../constant/collection.dart';
import '../models/order_model.dart';

class OrderProvider with ChangeNotifier {
  List<OrderModel> _orderData = [];

  Future<void> getAll(String userId, {String? statusId}) async {
    if (statusId == "0") {
      final data =
          await MyCollection.order.where("user_id", isEqualTo: userId).get();
      setData = [
        for (QueryDocumentSnapshot<Object?> item in data.docs)
          OrderModel.fromJson(item.data() as Map<String, dynamic>),
      ];
    } else if (statusId == "1") {
      final data = await MyCollection.order
          .where("user_id", isEqualTo: userId)
          .where("status_id", isEqualTo: statusId)
          .get();
      setData = [
        for (QueryDocumentSnapshot<Object?> item in data.docs)
          OrderModel.fromJson(item.data() as Map<String, dynamic>),
      ];
    } else if (statusId == "2") {
      final data = await MyCollection.order
          .where("user_id", isEqualTo: userId)
          .where("status_id", isEqualTo: statusId)
          .get();
      setData = [
        for (QueryDocumentSnapshot<Object?> item in data.docs)
          OrderModel.fromJson(item.data() as Map<String, dynamic>),
      ];
    } else if (statusId == "3") {
      final data = await MyCollection.order
          .where("user_id", isEqualTo: userId)
          .where("status_id", isEqualTo: statusId)
          .get();
      setData = [
        for (QueryDocumentSnapshot<Object?> item in data.docs)
          OrderModel.fromJson(item.data() as Map<String, dynamic>),
      ];
    } else if (statusId == "4") {
      final data = await MyCollection.order
          .where("user_id", isEqualTo: userId)
          .where("status_id", isEqualTo: statusId)
          .get();
      setData = [
        for (QueryDocumentSnapshot<Object?> item in data.docs)
          OrderModel.fromJson(item.data() as Map<String, dynamic>),
      ];
    }
  }

  set setData(List<OrderModel> data) {
    _orderData = data;
    notifyListeners();
  }

  List<OrderModel> get getData => _orderData;
  Future<void> deleteById(String id) async {
    _orderData.removeWhere((element) => element.orderId == id);
    await MyCollection.order.doc(id).delete();
    notifyListeners();
  }

  Future<OrderModel> getById({String? orderId}) async {
    final data = await MyCollection.order.doc(orderId).get();
    return OrderModel.fromJson(data.data() as Map<String, dynamic>);
  }

  Future<String> insertOrder({
    String? userId,
    String? categoryId,
    int? quantity,
    String? sizeId,
    String? paymentId,
    DateTime? date,
  }) async {
    final data = await MyCollection.order.get();
    final count = data.docs.length;
    final order = MyCollection.order.doc();
    order.set(
      {
        "id": order.id,
        "user_id": userId,
        "category_id": categoryId,
        "quantity": quantity,
        "size_id": sizeId,
        "payment_id": paymentId,
        "status_id": "1",
        "order_id": (count + 1).toString(),
        "order_date": date,
        "address": "-",
        "postal_code": "-",
      },
    );
    return order.id;
  }

  Future<void> updateStatus(
      {String? orderId,
      String? statusId,
      String? address,
      String? postalCode}) async {
    await MyCollection.order.doc(orderId).update({
      "status_id": statusId,
      "address": address,
      "postal_code": postalCode,
    });
  }
}
