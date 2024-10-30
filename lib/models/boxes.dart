import 'package:day/models/habit_history_model.dart';
import 'package:day/models/tasks_model.dart';
import 'package:hive/hive.dart';
import 'future_model.dart';
import 'habits_model.dart';
import 'history_model.dart';

class Boxes {
  static Box<TasksModel> addTaskToBase() =>
      Hive.box<TasksModel>('tasks');
  static Box<HistoryModel> addHistoryToBase() =>
      Hive.box<HistoryModel>('stories');
  static Box<HabitsModel> addHabitToBase() =>
      Hive.box<HabitsModel>('habit');
  static Box<FutureModel> addFutureToBase() =>
      Hive.box<FutureModel>('futures');
  static Box<HabitHistoryModel> addHabitHistoryToBase() =>
      Hive.box<HabitHistoryModel>('habitHistory');
}