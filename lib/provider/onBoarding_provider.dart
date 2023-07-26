import 'package:flutter/material.dart';

class OnBoardingProvider with ChangeNotifier {
  OnBoardingProvider({required int counter}) : _counter = counter {}
  get getCounter => _counter;
  int _counter;
  void increment() {
    _counter++;
    notifyListeners();
  }
}
