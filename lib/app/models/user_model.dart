import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
    UserModel({
        required this.email,
        required this.id,
        required this.imageUrl,
        required this.name,
        required this.roleId,
        required this.createAt,
        required this.updateAt,
    });

    final String email;
    final String id;
    final String imageUrl;
    final String name;
    final String roleId;
    final DateTime createAt;
    final DateTime updateAt;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        id: json["id"],
        imageUrl: json["image_url"],
        name: json["name"],
        roleId: json["role_id"],
        createAt: (json["create_at"] as Timestamp).toDate(),
        updateAt: (json["update_at"] as Timestamp).toDate(),
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "id": id,
        "image_url": imageUrl,
        "name": name,
        "role_id": roleId,
        "create_at": createAt,
        "update_at": updateAt,
    };
}
