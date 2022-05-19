import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
    NotificationModel({
        required this.id,
        required this.userId,
        required this.adminId,
        required this.title,
        required this.subtitle,
        required this.url,
        required this.createAt,
    });

    final String id;
    final String userId;
    final String adminId;
    final String title;
    final String subtitle;
    final String url;
    final DateTime createAt;

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        id: json["id"],
        userId: json["user_id"],
        adminId: json["admin_id"],
        title: json["title"],
        subtitle: json["subtitle"],
        url: json["url"],
        createAt: (json["create_at"] as Timestamp).toDate(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "admin_id": adminId,
        "subtitle": subtitle,
        "url": url,
        "create_at": createAt,
    };
}
