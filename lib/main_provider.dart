import 'dart:async';
import 'package:day/constants.dart';
import 'package:day/screens/create_future_screen.dart';
import 'package:day/screens/future_screen.dart';
import 'package:day/screens/plan_screen.dart';
import 'package:day/widgets/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/boxes.dart';
import 'models/future_model.dart';
import 'models/habits_model.dart';
import 'models/history_model.dart';
import 'models/tasks_model.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class MainProvider with ChangeNotifier {

  final nameTextController = TextEditingController();
  final habitTextController = TextEditingController();
  final descriptionTextController = TextEditingController();
  final recipeNameTextController = TextEditingController();
  final recipeDescriptionTextController = TextEditingController();
  final notesTextControllerOne = TextEditingController();
  final notesTextControllerTwo = TextEditingController();
  final notesTextControllerThree = TextEditingController();
  final futureNameTextController = TextEditingController();
  final futureDescriptionTextController = TextEditingController();
  final notesPageController = PageController();
  final futurePageController = PageController();

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
  String selectedDate = '';
  bool daniel = false;
  bool leonard = false;
  bool isFutureEdit = false;
  int editIndex = 0;
  double habitDaySlider = 10;

  String time1 = '';
  String time2 = '';
  String time3 = '';

  Box box = Hive.box('plans');
  late Box futureBox;

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

  void switchFutureButton(Box<FutureModel> box, int index, List<FutureModel> futures){
      box.putAt(index, FutureModel()
        ..name = futures[index].name
        ..description = futures[index].description
        ..deadline = futures[index].deadline
        ..status = futures[index].status == 'start'
            ? 'progress'
            : futures[index].status == 'progress'
            ? 'done'
            : 'start'
        ..daniel = futures[index].daniel
        ..leonard = futures[index].leonard
        ..time = DateTime.now().toString());
      notifyListeners();
  }

  switchName(String name){
    switch(name){
      case 'daniel':
        daniel = !daniel;
        notifyListeners();
        return;
      case 'leonard':
        leonard = !leonard;
        notifyListeners();
        return;
    }

  }

  void cleanDate(){
    selectedDate = '';
    notifyListeners();
  }

  Future showCalendar(context) async{
    final DateTime? picked = await showDatePicker(
      context: context,
      locale: const Locale('en', 'GB'),
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 10),
    );
    if(picked == null){
      selectedDate = DateTime.now().toString();
    }else{
      selectedDate = picked.toString();
    }
    notifyListeners();
  }

  void deleteAlarm(int index){
    switch(index){
      case 1:
        box.delete('time1');
        time1 = '';
        break;
      case 2:
        box.delete('time2');
        time2 = '';
        break;
      case 3:
        box.delete('time3');
        time3 = '';
        break;
    }
    notifyListeners();
  }

  void saveAlarms(){
    box.put('time1', time1);
    box.put('time2', time2);
    box.put('time3', time3);
  }

  DateTime initialTime(int index) {
    if(index == 1 && box.get('time1') != null && box.get('time1') != ''){
      return DateTime.tryParse(box.get('time1')) ?? DateTime.now();
    }
    if(index == 2 && box.get('time2') != null && box.get('time2') != ''){
      return DateTime.tryParse(box.get('time2')) ?? DateTime.now();
    }
    if(index == 3 && box.get('time3') != null && box.get('time3') != ''){
      return DateTime.tryParse(box.get('time3')) ?? DateTime.now();
    }
    else {
      return DateTime.now();
    }

  }

  String alarmTimes(int index){
    if(index == 1 && time1 != ''){
      return DateFormat('HH:mm').format(DateTime.parse(time1));
    }
    if(index == 2 && time2 != ''){
      return DateFormat('HH:mm').format(DateTime.parse(time2));
    }
    if(index == 3 && time3 != ''){
      return DateFormat('HH:mm').format(DateTime.parse(time3));
    }
    else {
      return '';
    }
  }

  Future saveNote(String note, int index) async{
    switch(index){
      case 0:
        await box.put('note', note);
        break;
      case 1:
        await box.put('note1', note);
        break;
      case 2:
        await box.put('note2', note);
        break;
    }
    notifyListeners();
  }

  Future readNote() async{
    notesTextControllerOne.text = await box.get('note') ?? '';
    notesTextControllerTwo.text = await box.get('note1') ?? '';
    notesTextControllerThree.text = await box.get('note2') ?? '';
  }

  void showTime(context, int index) async{
    showCupertinoModalPopup(
        context: context,
        builder: (context){
          return SizedBox(
            height: 300,
            child: Column(
              children: [
                TextButton(
                    onPressed: () => deleteAlarm(index),
                    child: const Text('Delete')),
                SizedBox(
                  height: 250,
                  child: CupertinoDatePicker(
                    backgroundColor: kWhite,
                      initialDateTime: initialTime(index),
                      onDateTimeChanged: (newTime){
                        index == 1
                            ? time1 = newTime.toString()
                            : index == 2
                            ? time2 = newTime.toString()
                            : time3 = newTime.toString();
                        notifyListeners();
                      },
                      use24hFormat: true,
                    mode: CupertinoDatePickerMode.time,
                  ),
                ),
              ],
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
    }else if(box.get('name2') == null){
      await box.put('name2', name);
      await box.put('description2', description);
      await box.put('icon2', icon);
      await box.put('status2', false);
    }else if(box.get('name3') == null){
      await box.put('name3', name);
      await box.put('description3', description);
      await box.put('icon3', icon);
      await box.put('status3', false);
    }
    notifyListeners();
  }

  Future deleteTaskFromPlan(int index) async{
    deleteAlarm(index);
    box.delete('name$index');
    box.delete('description$index');
    box.delete('status$index');
    box.delete('icon$index');
    box.delete('deadline$index');
    notifyListeners();
  }

  Future addFutureBase(context) async {
    final futures = FutureModel()
      ..name = futureNameTextController.text
      ..description = futureDescriptionTextController.text
      ..deadline = selectedDate
      ..status = 'start'
      ..daniel = daniel
      ..leonard = leonard
      ..time = DateTime.now().toString();
    final box = Boxes.addFutureToBase();
    box.add(futures);
    futureNameTextController.clear();
    futureDescriptionTextController.clear();
    selectedDate = '';
    daniel = false;
    leonard = false;
    notifyListeners();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) =>
        const FutureScreen()));
  }

  Future editFuture(context) async{
    futureBox.putAt(editIndex, FutureModel()
      ..name = futureNameTextController.text
      ..description = futureDescriptionTextController.text
      ..deadline = selectedDate
      ..status = 'start'
      ..daniel = daniel
      ..leonard = leonard
      ..time = DateTime.now().toString()
    );
    toFutureScreen(context);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) =>
        const FutureScreen()));
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
      time1 = box.get('time3') ?? '';
      time2 = box.get('time2') ?? '';
      time3 = box.get('time1') ?? '';
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
      ..name1 = box.get('name1') ?? ''
      ..description1 = box.get('description1')
      ..status1 = box.get('status3').toString()
      ..name2 = box.get('name2') ?? ''
      ..description2 = box.get('description2')
      ..status2 = box.get('status2').toString()
      ..name3 = box.get('name3') ?? ''
      ..description3 = box.get('description3') ?? ''
      ..status3 = box.get('status1').toString();
    final historyBox = Boxes.addHistoryToBase();
    historyBox.add(history);
    final nameHabitBox = [];
    final startHabitBox = [];
    final daysHabitBox = [];
    final progressHabitBox = [];
    final statusHabitBox = [];
    for(var h in Hive.box<HabitsModel>('habit').values){
      nameHabitBox.add(h.name);
      startHabitBox.add(h.start);
      daysHabitBox.add(h.days);
      progressHabitBox.add(h.progress);
      statusHabitBox.add(h.status);
    }
    for(var i = 0; i < nameHabitBox.length; i++){
      Hive.box<HabitsModel>('habit').putAt(i, HabitsModel()
        ..name = nameHabitBox[i]
        ..status = false
        ..start = startHabitBox[i]
        ..days = daysHabitBox[i]
        ..progress = progressHabitBox[i] + (statusHabitBox[i] ? '1' : '0')
      );
    }
    notifyListeners();
  }

  Future addHabitToBase() async {
    final habit = HabitsModel()
      ..name = habitTextController.text
      ..status = false
      ..days = habitDaySlider.toInt()
      ..progress = ''
      ..start = DateTime.now().toString();
    final box = Boxes.addHabitToBase();
    box.add(habit);
    habitTextController.clear();
    notifyListeners();
  }

  void switchHabit(Box<HabitsModel> box, int index, List<HabitsModel> habits)async{
    box.putAt(index, HabitsModel()
      ..name = habits[index].name
      ..status = !habits[index].status
      ..days = habits[index].days
      ..progress = habits[index].progress
      ..start = habits[index].start
    );
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
      Future.delayed(const Duration(milliseconds: 1000), () {
        time1 = box.get('time1') ?? '';
        time2 = box.get('time2') ?? '';
        time3 = box.get('time3') ?? '';
      });
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

  Future<void> addNotification() async{
    List<List<String>> n = [];
    n.add([box.get('name1') ?? '', time1]);
    n.add([box.get('name2') ?? '', time2]);
    n.add([box.get('name3') ?? '', time3]);
    AwesomeNotifications().removeChannel('scheduled');
    AwesomeNotifications().setChannel(NotificationChannel(
        channelKey: 'scheduled',
        channelName: 'Scheduled Notifications',
        channelDescription: 'Notification channel for basic tests'));
    for(int i = 0; i < n.length; i++){
      if(n[i][1] != ''){
        await AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: DateTime.now().microsecondsSinceEpoch.remainder(200),
            channelKey: 'scheduled',
            title: '${Emojis.sun} Time for ${n[i][0]}',
          ),
          schedule: NotificationCalendar(
              hour: int.parse(DateFormat('HH').format(DateTime.parse(n[i][1]))),
              minute: int.parse(DateFormat('mm').format(DateTime.parse(n[i][1]))),
              second: 0,
              repeats: false
          ),
        );
      }
    }
  }

  Future<void>showToAddHabit(context)async {
    Size size = MediaQuery.sizeOf(context);
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
              builder: (context, setState){
                return Container(
                    height: size.height * 0.3,
                    width: size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    margin: const EdgeInsets.only(bottom: 300),
                    decoration: const BoxDecoration(
                      color: kBlue,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextField(
                          controller: habitTextController,
                          style: const TextStyle(color: kWhite),
                          decoration: textFieldDecoration,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Slider(
                                divisions: 17,
                                activeColor: kWhite,
                                inactiveColor: kBlue,
                                secondaryActiveColor: kRed,
                                thumbColor: kTangerine,
                                value: habitDaySlider,
                                onChanged: (v) => setState((){
                                  changeHabitDaySlider(v);
                                }),
                                min: 10,
                                max: 180,
                              ),
                            ),
                            Text(habitDaySlider.toStringAsFixed(0), style: kTextStyle,)
                          ],
                        ),
                        ButtonWidget(
                          onTap: () {
                            addHabitToBase();
                            Navigator.of(context).pop();
                          },
                          icon: Icons.add,
                        ),
                      ],
                    )
                );
              }
          );
        });
  }

  void changeHabitDaySlider(double v){
    habitDaySlider = v;
    notifyListeners();
  }

  Future<void>showFutureDescription(context, List<FutureModel> futures, int index)async {
    Size size = MediaQuery.sizeOf(context);
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
                height: size.height * 0.4,
                width: size.width,
                margin: const EdgeInsets.only(bottom: 250),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: size.width * 0.4,
                          decoration: const BoxDecoration(
                            color: kTangerine,
                            borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),
                          ),
                        ),
                        Container(
                          width: size.width * 0.6,
                          decoration: const BoxDecoration(
                            color: kBlack,
                            borderRadius: BorderRadius.horizontal(right: Radius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: size.width,
                            height: size.height * 0.35,
                            margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(4)),
                              border: Border.all(width: 4, color: kBlack)
                            ),
                            child: Text(futures[index].description, style: kTextStyle,)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(futures[index].deadline.toString() != ''
                                ? DateFormat('dd.MM.yyyy').format(DateTime.parse(futures[index].deadline))
                                : '',
                                style: kTextStyle,),
                              Text(DateFormat('dd.MM.yyyy').format(DateTime.parse(futures[index].time)),
                                style: kTextStyle.copyWith(color: kWhite.withOpacity(0.1)),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                )
            ),
          );
        });
  }

  Future<void> deleteHabit(Box<HabitsModel> box, int index)async{
    box.deleteAt(index);
  }

  void editFutureShow(context, List<FutureModel> futures, int index, Box<FutureModel> box){
    futureBox = box;
    editIndex = index;
    isFutureEdit = true;
    futureNameTextController.text = futures[index].name;
    futureDescriptionTextController.text = futures[index].description;
    selectedDate = futures[index].deadline;
    daniel = futures[index].daniel;
    leonard = futures[index].leonard;
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) =>
        const CreateFutureScreen()));
  }

  void toFutureScreen(context){
    futureNameTextController.clear();
    futureDescriptionTextController.clear();
    selectedDate = '';
    daniel = false;
    leonard = false;
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) =>
        const FutureScreen()));
  }

  void deleteFuture(context){
    futureBox.deleteAt(editIndex);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) =>
        const FutureScreen()));
  }

}