import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
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
  String icon = 'art';


  Box box = Hive.box('plans');

  List<String> icons = [
    'art',
    'ball',
    'bicycle',
    'book',
    'cup',
    'laptop',
    'man',
    'map',
    'meditation',
    'phone',
    'pizza',
    'tree',
  ];

  void updateIcon(String i){
    icon = i;
    notifyListeners();
  }

  Future addTaskToPlan(String name, String description, String icon) async{
    if(box.get('name1') == null){
      await box.put('name1', name);
      await box.put('description1', description);
      await box.put('icon1', icon);
      await box.put('status1', false);
      await box.put('deadline1', '');
    }else if(box.get('name2') == null){
      await box.put('name2', name);
      await box.put('description2', description);
      await box.put('icon2', icon);
      await box.put('status2', false);
      await box.put('deadline2', '');
    }else if(box.get('name3') == null){
      await box.put('name3', name);
      await box.put('description3', description);
      await box.put('icon3', icon);
      await box.put('status3', false);
      await box.put('deadline3', '');
    }else{
      print('Not Empty');
    }
    notifyListeners();
  }

  Future deleteTaskFromPlan(int index) async{
    box.delete('name$index');
    box.delete('description$index');
    box.delete('status$index');
    box.delete('icon$index');
    box.delete('deadline$index');
    notifyListeners();
  }

  Future addTaskBase() async {
      final tasks = TasksModel()
        ..name = nameTextController.text
        ..description = descriptionTextController.text
        ..icon = icon
        ..time = DateTime.now().toString();
      final box = Boxes.addTaskToBase();
      box.add(tasks);
      nameTextController.clear();
      descriptionTextController.clear();
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