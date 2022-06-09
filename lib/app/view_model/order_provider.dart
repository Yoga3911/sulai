import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constant/collection.dart';
import '../models/order_model.dart';
import '../models/product_model.dart';

class OrderProvider with ChangeNotifier {
  List<OrderModel> _orderData = [];
  List<OrderModel> _orderDataProc = [];
  List<OrderModel> orderPerWeek = [];
  List<ProductModel> productData = [];

  int _sumData = 0;

  set setSum(int val) => _sumData = val;

  int get getSum => _sumData;

  int penjualanPerHari = 0;
  int pendapatanPerHari = 0;
  int penjualanPerHari2 = 0;
  int pendapatanPerHari2 = 0;

  void setOrderPerWeek(
      List<OrderModel> val, List<OrderModel> val2, List<ProductModel> product) {
    val.sort((a, b) => b.orderDate.compareTo(a.orderDate));
    orderPerWeek = val;
    penjualanPerHari = orderPerWeek.fold(0, (sum, e) => sum + e.quantity);
    penjualanPerHari2 = val2.fold(0, (sum, e) => sum + e.quantity);
    pendapatanPerHari = orderPerWeek.fold(
        0,
        (sum, e) =>
            sum +
            ((e.quantity *
                product
                    .where((element) => element.sizeId == e.sizeId)
                    .first
                    .price)));
    pendapatanPerHari2 = val2.fold(
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

  Future<void> getAllProc(String userId, {String? processId}) async {
    if (processId == "0") {
      final data = await MyCollection.order
          .where("user_id", isEqualTo: userId)
          .where("status_id", isEqualTo: "2")
          .get();
      setDataProc = [
        for (QueryDocumentSnapshot<Object?> item in data.docs)
          OrderModel.fromJson(item.data() as Map<String, dynamic>),
      ];
    } else if (processId == "4") {
      final data = await MyCollection.order
          .where("user_id", isEqualTo: userId)
          .where("process_id", isEqualTo: processId)
          .get();
      setDataProc = [
        for (QueryDocumentSnapshot<Object?> item in data.docs)
          OrderModel.fromJson(item.data() as Map<String, dynamic>),
      ];
    } else {
      final data = await MyCollection.order
          .where("user_id", isEqualTo: userId)
          .where("status_id", isEqualTo: "2")
          .where("process_id", isEqualTo: processId)
          .get();
      setDataProc = [
        for (QueryDocumentSnapshot<Object?> item in data.docs)
          OrderModel.fromJson(item.data() as Map<String, dynamic>),
      ];
    }
  }

  set setDataProc(List<OrderModel> data) {
    _orderDataProc = data;
    notifyListeners();
  }

  List<OrderModel> get getData => _orderData;
  List<OrderModel> get getDataProc => _orderDataProc;
  Future<void> deleteById(String id) async {
    _orderData.removeWhere((element) => element.id == id);
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
    String? checkoutUrl,
    String? chargeId,
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
        "process_id": "1",
        "order_id": (count + 1).toString(),
        "order_date": date,
        "checkout_url": checkoutUrl,
        "charge_id": chargeId,
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
    if (address == null && postalCode == null) {
      await MyCollection.order.doc(orderId).update({
        "status_id": statusId,
      });
      return;
    }
    await MyCollection.order.doc(orderId).update({
      "status_id": statusId,
      "address": address,
      "postal_code": postalCode,
    });
  }

  Future<void> updatePaymentStatus({
    required String orderId,
    required String status,
    String? address,
    String? postalCode,
  }) async {
    switch (status) {
      case "SUCCEEDED":
        await MyCollection.order.doc(orderId).update(
          {
            "status_id": "2",
            "address": address,
            "postal_code": postalCode,
          },
        );
        break;
      case "FAILED":
        await MyCollection.order.doc(orderId).update(
          {
            "status_id": "4",
          },
        );
        break;
    }
  }

  Future<void> updateStatusState({
    String? statusId,
    String? orderId,
    String? processId,
  }) async {
    if (processId != null) {
      await MyCollection.order
          .doc(orderId)
          .update({"status_id": statusId, "process_id": processId});
    } else {
      await MyCollection.order.doc(orderId).update({
        "status_id": statusId,
      });
    }
  }

  Future<void> updateProcessState({String? processId, String? orderId}) async {
    await MyCollection.order.doc(orderId).update({
      "process_id": processId,
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
  List<OrderModel> satDataB = [];
  List<OrderModel> monData = [];
  List<OrderModel> tueData = [];
  List<OrderModel> wedData = [];
  List<OrderModel> thuData = [];
  List<OrderModel> friData = [];
  List<OrderModel> satData = [];
  List<OrderModel> sunData = [];

  List<int> countPerMonth({DateTime? selectedDate}) {
    List<int> countWeek = List.generate(8, (_) => 0);
    List<OrderModel> satB = getOrderD
        .where((element) =>
            element.orderDate.year == selectedDate!.year &&
            element.orderDate.month == selectedDate.month &&
            (element.orderDate.day / 7).ceil() ==
                (selectedDate.subtract(const Duration(days: 1)).day / 7)
                    .ceil() &&
            element.orderDate.weekday == 7)
        .toList();
    countWeek[7] = satB.where((element) => element.statusId == "3").length;
    satDataB = satB;
    List<OrderModel> mon = getOrderD
        .where((element) =>
            element.orderDate.year == selectedDate!.year &&
            element.orderDate.month == selectedDate.month &&
            (element.orderDate.day / 7).ceil() ==
                (selectedDate.day / 7).ceil() &&
            element.orderDate.weekday == 1)
        .toList();
    countWeek[1] = mon.where((element) => element.statusId == "3").length;
    monData = mon;
    List<OrderModel> tue = getOrderD
        .where((element) =>
            element.orderDate.year == selectedDate!.year &&
            element.orderDate.month == selectedDate.month &&
            (element.orderDate.day / 7).ceil() ==
                (selectedDate.day / 7).ceil() &&
            element.orderDate.weekday == 2)
        .toList();
    countWeek[2] = tue.where((element) => element.statusId == "3").length;
    tueData = tue;
    List<OrderModel> wed = getOrderD
        .where((element) =>
            element.orderDate.year == selectedDate!.year &&
            element.orderDate.month == selectedDate.month &&
            (element.orderDate.day / 7).ceil() ==
                (selectedDate.day / 7).ceil() &&
            element.orderDate.weekday == 3)
        .toList();
    countWeek[3] = wed.where((element) => element.statusId == "3").length;
    wedData = wed;
    List<OrderModel> thu = getOrderD
        .where((element) =>
            element.orderDate.year == selectedDate!.year &&
            element.orderDate.month == selectedDate.month &&
            (element.orderDate.day / 7).ceil() ==
                (selectedDate.day / 7).ceil() &&
            element.orderDate.weekday == 4)
        .toList();
    countWeek[4] = thu.where((element) => element.statusId == "3").length;
    thuData = thu;
    List<OrderModel> fri = getOrderD
        .where((element) =>
            element.orderDate.year == selectedDate!.year &&
            element.orderDate.month == selectedDate.month &&
            (element.orderDate.day / 7).ceil() ==
                (selectedDate.day / 7).ceil() &&
            element.orderDate.weekday == 5)
        .toList();
    countWeek[5] = fri.where((element) => element.statusId == "3").length;
    friData = fri;
    List<OrderModel> sat = getOrderD
        .where((element) =>
            element.orderDate.year == selectedDate!.year &&
            element.orderDate.month == selectedDate.month &&
            (element.orderDate.day / 7).ceil() ==
                (selectedDate.day / 7).ceil() &&
            element.orderDate.weekday == 6)
        .toList();
    countWeek[6] = sat.where((element) => element.statusId == "3").length;
    satData = sat;
    List<OrderModel> sun = getOrderD
        .where((element) =>
            element.orderDate.year == selectedDate!.year &&
            element.orderDate.month == selectedDate.month &&
            (element.orderDate.day / 7).ceil() ==
                (selectedDate.day / 7).ceil() &&
            element.orderDate.weekday == 7)
        .toList();
    countWeek[0] = sun.where((element) => element.statusId == "3").length;
    sunData = sun;
    int sum = 0;
    for (int i = 0; i < countWeek.length - 1; i++) {
      sum += countWeek[i];
    }
    setSum = sum;
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

  DateTime selectedDate2 = DateTime.now();

  selectDate2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2099),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked.subtract(const Duration(days: 1));
      penjualanPerHari = 0;
      orderPerWeek = [];
      notifyListeners();
    }
  }
}
