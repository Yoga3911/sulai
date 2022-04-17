import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sulai/app/constant/collection.dart';
import 'package:sulai/app/models/notifaction_model.dart';

class NotificationProvider with ChangeNotifier {
  bool _isActive = false;

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

  Future<void> getAll() async {
    final data = await MyCollection.notification
        .orderBy("create_at", descending: true)
        .get();

    setData = [
      for (QueryDocumentSnapshot<Object?> item in data.docs)
        NotificationModel.fromJson(item.data() as Map<String, dynamic>),
    ];
  }

  set setData(List<NotificationModel> data) => _notifData = data;

  List<NotificationModel> get getData => _notifData;

  Future<void> deleteById(String id) async {
    _notifData.removeWhere((element) => element.id == id);
    setMinusCount = -1;
    await MyCollection.notification.doc(id).delete();
    notifyListeners();
  }
}
