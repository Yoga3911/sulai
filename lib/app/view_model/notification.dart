import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sulai/app/constant/collection.dart';
import 'package:sulai/app/models/notifaction_model.dart';

class NotificationProvider with ChangeNotifier {
  bool _isActive = false;

  bool isOpen = false;

  set setActive(bool val) => _isActive = val;

  set setActiveRef(bool val) {
    _isActive = val;
    notifyListeners();
  }

  bool get getActive => _isActive;

  int _count = 0;

  set setCount(int val) => _count = val;
  set setMinusCount(int val) => _count += val;

  int get getCount => _count;

  List<NotificationModel> _notifData = [];

  Future<void> getAll({String? userId}) async {
    final data = await MyCollection.notification
        .where("user_id", isEqualTo: userId)
        .get();

    setData = [
      for (QueryDocumentSnapshot<Object?> item in data.docs)
        NotificationModel.fromJson(item.data() as Map<String, dynamic>),
    ];
  }

  set setData(List<NotificationModel> data) {
    _notifData = data;
    _notifData.sort(
      (a, b) => b.createAt.compareTo(a.createAt),
    );
  }

  List<NotificationModel> get getData => _notifData;

  Future<void> deleteById(String id) async {
    _notifData.removeWhere((element) => element.id == id);
    setMinusCount = -1;
    await MyCollection.notification.doc(id).delete();
    log("Hapuss");
    notifyListeners();
  }

  Future<void> insertNotif(
      {required String userId,
      required String adminId,
      required String title,
      required String subtitle}) async {
    final docId = MyCollection.notification.doc();
    docId.set(
      NotificationModel(
        id: docId.id,
        userId: userId,
        adminId: adminId,
        title: title,
        subtitle: subtitle,
        url: "-",
        createAt: DateTime.now(),
      ).toJson(),
    );
  }
}
