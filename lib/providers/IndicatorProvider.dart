import 'package:flutter/cupertino.dart';

class IndicatorProvider extends ChangeNotifier {
  int _index = 0;

  int get index => _index;

  set(int index) {
    _index = index;
    notifyListeners();
  }
}
