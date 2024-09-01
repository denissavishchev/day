import 'package:hive/hive.dart';
part 'history_model.g.dart';

@HiveType(typeId: 3)
class HistoryModel extends HiveObject{
  @HiveField(0)
  late String time;
  @HiveField(1)
  late String duration;
  @HiveField(2)
  late String name1;
  @HiveField(3)
  late String description1;
  @HiveField(4)
  late String status1;
  @HiveField(5)
  late String name2;
  @HiveField(6)
  late String description2;
  @HiveField(7)
  late String status2;
  @HiveField(8)
  late String name3;
  @HiveField(9)
  late String description3;
  @HiveField(10)
  late String status3;
}