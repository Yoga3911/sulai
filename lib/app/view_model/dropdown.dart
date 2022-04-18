import 'package:flutter/material.dart';

class DropDownNotifier with ChangeNotifier {
  int _rasa = 1;
  int _kemasan = 1;
  int _pembayaran = 1;
  String _image = "assets/images/sulai2.png";

  set setImg(String val) {
    _image = val;
    notifyListeners();
  }

  String get getImg => _image;

  set setRasa(int val) {
    _rasa = val;
    notifyListeners();
  }

  set setKemasan(int val) {
    _kemasan = val;
    notifyListeners();
  }

  set setPembayaran(int val) {
    _pembayaran = val;
    notifyListeners();
  }

  int get getRasa => _rasa;

  int get getKemasan => _kemasan;
  
  int get getPembayaran => _pembayaran;

  DateTime selectedDate = DateTime.now().add(const Duration(days: 2));

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2099),
    );
    if (picked != null && picked != selectedDate) {
        selectedDate = picked;
        notifyListeners();
    }
  }
}
