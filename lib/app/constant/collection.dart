import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MyCollection {
  MyCollection._();

  static final CollectionReference user = FirebaseFirestore.instance.collection("user");
  static final CollectionReference product = FirebaseFirestore.instance.collection("product");
  static final CollectionReference notification = FirebaseFirestore.instance.collection("notification");
  static final CollectionReference order = FirebaseFirestore.instance.collection("order");
  static final CollectionReference status = FirebaseFirestore.instance.collection("status");
  static final CollectionReference ulasan = FirebaseFirestore.instance.collection("ulasan");
  static final CollectionReference size = FirebaseFirestore.instance.collection("size");
  static final CollectionReference chat = FirebaseFirestore.instance.collection("chat");
  static final FirebaseStorage storage = FirebaseStorage.instance;
}