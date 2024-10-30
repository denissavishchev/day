import 'package:hive/hive.dart';
part 'habit_history_model.g.dart';

@HiveType(typeId: 23)
class HabitHistoryModel extends HiveObject{
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String startTime;
  @HiveField(2)
  late String endTime;
  @HiveField(3)
  late String totalDays;
  @HiveField(4)
  late String goodDays;
  @HiveField(5)
  late String badDays;
}