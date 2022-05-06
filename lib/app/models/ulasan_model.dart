import 'package:cloud_firestore/cloud_firestore.dart';

class UlasanModel {
    UlasanModel({
        required this.id,
        required this.userId,
        required this.ulasan,
        required this.date,
    });

    final String id;
    final String userId;
    final String ulasan;
    final DateTime date;

    factory UlasanModel.fromJson(Map<String, dynamic> json) => UlasanModel(
        id: json["id"],
        userId: json["user_id"],
        ulasan: json["ulasan"],
        date: (json["date"] as Timestamp).toDate(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "ulasan": ulasan,
        "date": date,
    };
}
