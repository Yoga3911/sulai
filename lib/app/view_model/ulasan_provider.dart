import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sulai/app/constant/collection.dart';
import 'package:sulai/app/models/ulasan_model.dart';

class UlasanProvider with ChangeNotifier {
  Future<List<UlasanModel>> getAll() async {
    final data =
        await MyCollection.ulasan.orderBy("date", descending: true).get();
    return <UlasanModel>[
      for (QueryDocumentSnapshot<Object?> item in data.docs)
        UlasanModel.fromJson(item.data() as Map<String, dynamic>)
    ];
  }

  Future<List<QueryDocumentSnapshot<Object?>>> getById({String? userId}) async {
    final data =
        await MyCollection.ulasan.where("user_id", isEqualTo: userId).get();
    return data.docs;
  }

  Future<void> insertData({
    String? userId,
    String? ulasan,
  }) async {
    final doc = MyCollection.ulasan.doc();
    doc.set(
      {
        "id": doc.id,
        "user_id": userId,
        "ulasan": ulasan,
        "date": DateTime.now(),
      },
    );
  }

  Future<void> updateDate({String? ulasanId, String? ulasan}) async {
    await MyCollection.ulasan.doc(ulasanId).update(
      {
        "ulasan": ulasan,
        "date": DateTime.now(),
      },
    );
  }
}
