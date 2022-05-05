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

  Future<ProductModel> getById({String? categoryId}) async {
    final data = await MyCollection.product
        .where("category_id", isEqualTo: categoryId)
        .get();
    return ProductModel.fromJson(
        data.docs.first.data() as Map<String, dynamic>);
  }
}
