import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../constant/collection.dart';
import '../models/order_model.dart';

class OrderProvider with ChangeNotifier {
  List<OrderModel> _orderData = [];

  Future<void> getAll(String userId, {String? statusId}) async {
    if (statusId == "0") {
      final data = await MyCollection.order.get();
      setData = [
        for (QueryDocumentSnapshot<Object?> item in data.docs)
          OrderModel.fromJson(item.data() as Map<String, dynamic>),
      ];
    } else if (statusId == "1") {
      final data = await MyCollection.order
          .where("status_id", isEqualTo: statusId)
          .get();
      setData = [
        for (QueryDocumentSnapshot<Object?> item in data.docs)
          OrderModel.fromJson(item.data() as Map<String, dynamic>),
      ];
    } else if (statusId == "2") {
      final data = await MyCollection.order
          .where("status_id", isEqualTo: statusId)
          .get();
      setData = [
        for (QueryDocumentSnapshot<Object?> item in data.docs)
          OrderModel.fromJson(item.data() as Map<String, dynamic>),
      ];
    } else if (statusId == "3") {
      final data = await MyCollection.order
          .where("status_id", isEqualTo: statusId)
          .get();
      setData = [
        for (QueryDocumentSnapshot<Object?> item in data.docs)
          OrderModel.fromJson(item.data() as Map<String, dynamic>),
      ];
    } else if (statusId == "4") {
      final data = await MyCollection.order
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
}
