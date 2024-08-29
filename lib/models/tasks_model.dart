import 'package:hive/hive.dart';
part 'tasks_model.g.dart';

@HiveType(typeId: 1)
class TasksModel extends HiveObject{
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String description;
  @HiveField(2)
  late String icon;
  @HiveField(3)
  late String time;
}