import 'package:day/models/tasks_model.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<TasksModel> addTaskToBase() =>
      Hive.box<TasksModel>('tasks');
}