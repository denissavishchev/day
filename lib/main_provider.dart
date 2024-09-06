import 'dart:async';
import 'package:day/constants.dart';
import 'package:day/screens/plan_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/boxes.dart';
import 'models/history_model.dart';
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
  String icon = 'drums';

  DateTime time1 = DateTime.now();
  DateTime time2 = DateTime.now();
  DateTime time3 = DateTime.now();


  Box box = Hive.box('plans');

  List<String> icons = [
    'drums',
    'art',
    'toy',
    'ball',
    'piano',
    'cat',
    'bicycle',
    'house',
    'book',
    'cup',
    'butterfly',
    'money',
    'laptop',
    'guitar',
    'man',
    'sushi',
    'photo',
    'cake',
    'cards',
    'map',
    'bulb',
    'meditation',
    'gear',
    'phone',
    'globe',
    'pizza',
    'dog',
    'bath',
    'tree',
    'car',
  ];

  void showTime(context, int index){
    showCupertinoModalPopup(
        context: context,
        builder: (context){
          return SizedBox(
            height: 250,
            child: CupertinoDatePicker(
              backgroundColor: kWhite,
                initialDateTime: index == 1 ? time1 : index == 2 ? time2 : time3,
                onDateTimeChanged: (newTime){
                  index == 1 ? time1 = newTime : index == 2 ? time2 = newTime : time3 = newTime;
                  notifyListeners();
                },
                use24hFormat: true,
              mode: CupertinoDatePickerMode.time,
            ),
          );
        }
    );
  }

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
      if(box.get('status1') != null){
        checkedOne = box.get('status1');
      }
      if(box.get('status2') != null){
        checkedTwo = box.get('status2');
      }
      if(box.get('status3') != null){
        checkedThree = box.get('status3');
      }
      notifyListeners();
    }
  }

  void endDay(SharedPreferences prefs) async{
    final history = HistoryModel()
      ..time = prefs.getString('startTime').toString()
      ..duration = dayDuration
      ..name1 = box.get('name1')
      ..description1 = box.get('description1')
      ..status1 = box.get('status3').toString()
      ..name2 = box.get('name2')
      ..description2 = box.get('description2')
      ..status2 = box.get('status2').toString()
      ..name3 = box.get('name3')
      ..description3 = box.get('description3')
      ..status3 = box.get('status1').toString();
    final historyBox = Boxes.addHistoryToBase();
    historyBox.add(history);
    notifyListeners();
  }

  void switchDay(context) async{
    day = !day;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(day){
      await prefs.setBool('day', true);
      await prefs.setString('startTime', DateTime.now().toString());
      startTime = DateFormat('HH:mm').format(DateTime.parse(prefs.getString('startTime').toString()));
      Future.delayed(const Duration(milliseconds: 1000), () => Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const PlanScreen())));
      await box.put('status1', false);
      await box.put('status2', false);
      await box.put('status3', false);
      checkedOne = false;
      checkedTwo = false;
      checkedThree = false;
      notifyListeners();
    }else{
      await prefs.setString('endTime', DateTime.now().toString());
      endTime = DateFormat('HH:mm').format(DateTime.parse(prefs.getString('endTime').toString()));
      await prefs.setString('previousDayDuration', dayDuration);
      previousDayDuration = prefs.getString('previousDayDuration').toString();
      await prefs.setBool('day', false);
      endDay(prefs);
    }
    notifyListeners();
  }

  void switchChecked(int checked)async{
    if(checked == 1){
        checkedOne = !checkedOne;
        await box.put('status1', checkedOne);
    }if(checked == 2){
      checkedTwo = !checkedTwo;
      await box.put('status2', checkedTwo);
    }if(checked == 3){
      checkedThree = !checkedThree;
      await box.put('status3', checkedThree);
    }
  notifyListeners();
  }

}