import 'package:flutter/material.dart';

class DropDownNotifier with ChangeNotifier {
  String rasa = "";
  String _kemasan = "";
  int _pembayaran = 1;
  String image = "";
  String cityId = "1";
  bool isCityId = false;
  String courier = "jne";
  // bool isCityId = false;

  set setCityId(String id) {
    cityId = id;
    notifyListeners();
  }

  set setCourier(String id) {
    courier = id;
    notifyListeners();
  }

  set setImg(String val) {
    image = val;
    notifyListeners();
  }

  String get getImg => image;

  set setRasa(String val) {
    rasa = val;
    notifyListeners();
  }

  set setKemasan(String val) {
    _kemasan = val;
    notifyListeners();
  }

  set setPembayaran(int val) {
    _pembayaran = val;
    notifyListeners();
  }

  String get getRasa => rasa;

  String get getKemasan => _kemasan;

  int get getPembayaran => _pembayaran;

  DateTime selectedDate = DateTime.now().add(const Duration(days: 2));

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: selectedDate,
      lastDate: DateTime(2099),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      notifyListeners();
    }
  }
}

class DropDownNotifier2 with ChangeNotifier {
  String courier = "jne";
  // bool isCityId = false;
  set setDropdown(bool val) {
    notifyListeners();
  }

  set setCourier(String id) {
    courier = id;
    notifyListeners();
  }
}
