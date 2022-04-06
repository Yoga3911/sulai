import 'package:cloud_firestore/cloud_firestore.dart';

class MyCollection {
  MyCollection._();

  static final user = FirebaseFirestore.instance.collection("user");
}