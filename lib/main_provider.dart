import 'package:flutter/material.dart';

class MainProvider with ChangeNotifier {

  bool day = false;
  bool checkedOne = false;
  bool checkedTwo = false;
  bool checkedThree = false;

  void switchDay(){
    day = !day;
    notifyListeners();
  }

  void switchChecked(int checked){
    if(checked == 1){
        checkedOne = !checkedOne;
    }if(checked == 2){
      checkedTwo = !checkedTwo;
    }if(checked == 3){
      checkedThree = !checkedThree;
    }
  notifyListeners();
  }

}