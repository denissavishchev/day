import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/boxes.dart';
import 'models/tasks_model.dart';

class MainProvider with ChangeNotifier {

  final nameTextController = TextEditingController();
  final descriptionTextController = TextEditingController();

  bool day = true;
  bool checkedOne = false;
  bool checkedTwo = false;
  bool checkedThree = false;
  String startTime = '';
  String startState = '';
  String dayDuration = '';
  String endTime = '';
  String previousDayDuration = '';

  late XFile? file;
  String base64String = '';

  Future addTaskBase() async {
      final tasks = TasksModel()
        ..name = nameTextController.text
        ..description = descriptionTextController.text
        ..photo = base64String
        ..time = DateTime.now().toString();
      final box = Boxes.addTaskToBase();
      box.add(tasks);
      base64String = '';
      nameTextController.clear();
      descriptionTextController.clear();
    notifyListeners();
  }

  Future pickAnImage()async{
    ImagePicker image = ImagePicker();
    file = await image.pickImage(source: ImageSource.camera,
        maxHeight: 1000.0,
        maxWidth: 1000.0);
    if(file == null) return;
    List<int> imageBytes = File(file!.path).readAsBytesSync();
    base64String = base64Encode(imageBytes);
    notifyListeners();
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void updateTimer() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final duration = prefs.getString('startTime') == null
        ? DateTime.now().difference(DateTime.now())
        : DateTime.now().difference(DateTime.parse(prefs.getString('startTime').toString()));
    dayDuration = formatDuration(duration);
    notifyListeners();
  }

  void initDay() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('startTime') == null){
      day = false;
      notifyListeners();
    }else{
      startTime = DateFormat('HH:mm').format(DateTime.parse(prefs.getString('startTime').toString()));
      endTime = DateFormat('HH:mm').format(DateTime.parse(prefs.getString('endTime').toString()));
      previousDayDuration = prefs.getString('previousDayDuration').toString();
      day = prefs.getBool('day')!;
    }
  }

  void switchDay() async{
    day = !day;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(day){
      await prefs.setBool('day', true);
      await prefs.setString('startTime', DateTime.now().toString());
      startTime = DateFormat('HH:mm').format(DateTime.parse(prefs.getString('startTime').toString()));
    }else{
      await prefs.setString('endTime', DateTime.now().toString());
      endTime = DateFormat('HH:mm').format(DateTime.parse(prefs.getString('endTime').toString()));
      await prefs.setString('previousDayDuration', dayDuration);
      previousDayDuration = prefs.getString('previousDayDuration').toString();
      await prefs.setBool('day', false);
    }
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