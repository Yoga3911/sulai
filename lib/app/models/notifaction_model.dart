import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
    NotificationModel({
        required this.id,
        required this.userId,
        required this.title,
        required this.subtitle,
        required this.createAt,
    });

    final String id;
    final String userId;
    final String title;
    final String subtitle;
    final DateTime createAt;

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        subtitle: json["subtitle"],
        createAt: (json["create_at"] as Timestamp).toDate(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "subtitle": subtitle,
        "create_at": createAt,
    };
}
