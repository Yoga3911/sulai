import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
    ProductModel({
        required this.id,
        required this.name,
        required this.imageUrl,
        required this.price,
        required this.adminId,
        required this.categoryId,
        required this.sizeId,
        required this.createAt,
        required this.updateAt,
    });

    final String id;
    final String name;
    final String imageUrl;
    final int price;
    final String adminId;
    final String categoryId;
    final String sizeId;
    final DateTime createAt;
    final DateTime updateAt;

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        imageUrl: json["image_url"],
        price: json["price"],
        adminId: json["admin_id"],
        categoryId: json["category_id"],
        sizeId: json["size_id"],
        createAt: (json["create_at"] as Timestamp).toDate(),
        updateAt: (json["update_at"] as Timestamp).toDate(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image_url": imageUrl,
        "price": price,
        "admin_id": adminId,
        "category_id": categoryId,
        "size_id": sizeId,
        "create_at": createAt,
        "update_at": updateAt,
    };
}
