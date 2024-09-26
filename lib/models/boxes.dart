import 'package:day/models/tasks_model.dart';
import 'package:hive/hive.dart';
import 'history_model.dart';

class Boxes {
  static Box<TasksModel> addTaskToBase() =>
      Hive.box<TasksModel>('tasks');
  static Box<HistoryModel> addHistoryToBase() =>
      Hive.box<HistoryModel>('history');
}