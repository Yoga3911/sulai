import 'package:cloud_firestore/cloud_firestore.dart';

class MyCollection {
  MyCollection._();

  static final CollectionReference user = FirebaseFirestore.instance.collection("user");
  static final CollectionReference admin = FirebaseFirestore.instance.collection("admin");
  static final CollectionReference product = FirebaseFirestore.instance.collection("product");
}