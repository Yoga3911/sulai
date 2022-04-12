import 'package:flutter/cupertino.dart';

class IndexSlider with ChangeNotifier {
  int _index = 0;

  set setIndex(int index) => _index = index;
  int get getIndex => _index;
}