import 'package:flutter/material.dart';

class MainProvider with ChangeNotifier {

  bool day = false;

  void switchDay(){
    day = !day;
    notifyListeners();
  }

}