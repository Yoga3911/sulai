import 'package:flutter/cupertino.dart';

class DropDownNotifier with ChangeNotifier {
  int _rasa = 1;
  int _kemasan = 1;
  int _pembayaran = 1;

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
}