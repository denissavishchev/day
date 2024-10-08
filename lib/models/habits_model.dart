import 'package:hive/hive.dart';
part 'habits_model.g.dart';

@HiveType(typeId: 6)
class HabitsModel extends HiveObject{
  @HiveField(0)
  late String name;
  @HiveField(1)
  late bool status;
  @HiveField(2)
  late String time;
}