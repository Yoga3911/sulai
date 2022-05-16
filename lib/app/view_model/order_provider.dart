import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constant/collection.dart';
import '../models/order_model.dart';
import '../models/product_model.dart';

class OrderProvider with ChangeNotifier {
  List<OrderModel> _orderData = [];
  List<OrderModel> orderPerWeek = [];
  List<ProductModel> productData = [];

  int _sumData = 0;

  set setSum(int val) => _sumData = val;

  int get getSum => _sumData;

  int penjualanPerHari = 0;
  int pendapatanPerHari = 0;

  void setOrderPerWeek(List<OrderModel> val, List<ProductModel> product) {
    val.sort((a, b) => b.orderDate.compareTo(a.orderDate));
    orderPerWeek = val;
    penjualanPerHari = orderPerWeek.fold(0, (sum, e) => sum + e.quantity);
    pendapatanPerHari = orderPerWeek.fold(
        0,
        (sum, e) =>
            sum +
            ((e.quantity *
                product
                    .where((element) => element.sizeId == e.sizeId)
                    .first
                    .price)));
    notifyListeners();
  }

  Future<void> getAll(String userId, {String? statusId}) async {
    if (statusId == "0") {
      final data =
          await MyCollection.order.where("user_id", isEqualTo: userId).get();
      setData = [
        for (QueryDocumentSnapshot<Object?> item in data.docs)
          OrderModel.fromJson(item.data() as Map<String, dynamic>),
      ];
    } else {
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
        "product_id": categoryId,
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

  Future<void> updateStatusState({String? statusId, String? orderId}) async {
    await MyCollection.order.doc(orderId).update({
      "status_id": statusId,
    });
  }

  List<OrderModel>? _orderD;

  Future<void> getAllOrder({int? year}) async {
    final data =
        await MyCollection.order.where("status_id", isEqualTo: "3").get();
    setOrderD = <OrderModel>[
      for (QueryDocumentSnapshot<Object?> item in data.docs)
        OrderModel.fromJson(item.data() as Map<String, dynamic>)
    ];
  }

  set setOrderD(List<OrderModel> val) => _orderD = val;

  List<OrderModel> get getOrderD => _orderD!;
  List<OrderModel> monData = [];
  List<OrderModel> tueData = [];
  List<OrderModel> wedData = [];
  List<OrderModel> thuData = [];
  List<OrderModel> friData = [];
  List<OrderModel> satData = [];
  List<OrderModel> sunData = [];

  List<int> countPerMonth({DateTime? selectedDate}) {
    List<int> countWeek = List.generate(7, (_) => 0);
    List<OrderModel> mon = getOrderD
        .where((element) =>
            element.orderDate.year == selectedDate!.year &&
            element.orderDate.month == selectedDate.month &&
            (element.orderDate.day / 7).ceil() ==
                (selectedDate.day / 7).ceil() &&
            element.orderDate.weekday == 1)
        .toList();
    countWeek[1] = mon.length;
    monData = mon;
    List<OrderModel> tue = getOrderD
        .where((element) =>
            element.orderDate.year == selectedDate!.year &&
            element.orderDate.month == selectedDate.month &&
            (element.orderDate.day / 7).ceil() ==
                (selectedDate.day / 7).ceil() &&
            element.orderDate.weekday == 2)
        .toList();
    countWeek[2] = tue.length;
    tueData = tue;
    List<OrderModel> wed = getOrderD
        .where((element) =>
            element.orderDate.year == selectedDate!.year &&
            element.orderDate.month == selectedDate.month &&
            (element.orderDate.day / 7).ceil() ==
                (selectedDate.day / 7).ceil() &&
            element.orderDate.weekday == 3)
        .toList();
    countWeek[3] = wed.length;
    wedData = wed;
    List<OrderModel> thu = getOrderD
        .where((element) =>
            element.orderDate.year == selectedDate!.year &&
            element.orderDate.month == selectedDate.month &&
            (element.orderDate.day / 7).ceil() ==
                (selectedDate.day / 7).ceil() &&
            element.orderDate.weekday == 4)
        .toList();
    countWeek[4] = thu.length;
    thuData = thu;
    List<OrderModel> fri = getOrderD
        .where((element) =>
            element.orderDate.year == selectedDate!.year &&
            element.orderDate.month == selectedDate.month &&
            (element.orderDate.day / 7).ceil() ==
                (selectedDate.day / 7).ceil() &&
            element.orderDate.weekday == 5)
        .toList();
    countWeek[5] = fri.length;
    friData = fri;
    List<OrderModel> sat = getOrderD
        .where((element) =>
            element.orderDate.year == selectedDate!.year &&
            element.orderDate.month == selectedDate.month &&
            (element.orderDate.day / 7).ceil() ==
                (selectedDate.day / 7).ceil() &&
            element.orderDate.weekday == 6)
        .toList();
    countWeek[6] = sat.length;
    satData = sat;
    List<OrderModel> sun = getOrderD
        .where((element) =>
            element.orderDate.year == selectedDate!.year &&
            element.orderDate.month == selectedDate.month &&
            (element.orderDate.day / 7).ceil() ==
                (selectedDate.day / 7).ceil() &&
            element.orderDate.weekday == 7)
        .toList();
    countWeek[0] = sun.length;
    sunData = sun;
    setSum = countWeek
        .map((order) => order)
        .fold(0, (int prev, amount) => prev + amount);
    return countWeek;
  }

  DateTime selectedDate = DateTime.now();

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2099),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      penjualanPerHari = 0;
      orderPerWeek = [];
      notifyListeners();
    }
  }
}
