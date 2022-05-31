import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sulai/app/constant/collection.dart';
import 'package:sulai/app/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  Future<List<ProductModel>> getAll() async {
    final data = await MyCollection.product.get();

    return <ProductModel>[
      for (QueryDocumentSnapshot<Object?> item in data.docs)
        ProductModel.fromJson(item.data() as Map<String, dynamic>)
    ];
  }

  Future<ProductModel> getById({String? id}) async {
    final data = await MyCollection.product
        .where("id", isEqualTo: id)
        .get();
    return ProductModel.fromJson(
        data.docs.first.data() as Map<String, dynamic>);
  }

  Future<void> editProduct({
    String? name,
    String? productId,
    int? price,
    String? image,
    String? size,
    int? discount,
    int? discProd,
  }) async {
    await MyCollection.product.doc(productId).update(
      {
        "name": name,
        "image_url": image,
        "price": price,
        "discount": discount,
        "disc_prod": discProd,
        "size_id": size,
        "update_at": DateTime.now(),
      },
    );
  }

  Future<void> addProduct({
    String? name,
    int? price,
    String? image,
    String? size,
    String? userId,
    int? discount,
    int? discProd,
  }) async {
    final doc = MyCollection.product.doc();
    await doc.set(
      {
        "id": doc.id,
        "admin_id": userId,
        "name": name,
        "category_id": "1",
        "image_url": image,
        "price": price,
        "discount": discount,
        "disc_prod": discProd,
        "size_id": size,
        "update_at": DateTime.now(),
        "create_at": DateTime.now(),
      },
    );
  }

  Future<void> deleteProduct({String? productId}) async {
    await MyCollection.product.doc(productId).delete();
  }
}
