import 'package:hive/hive.dart';
part 'future_model.g.dart';

@HiveType(typeId: 9)
class FutureModel extends HiveObject{
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String description;
  @HiveField(2)
  late String deadline;
  @HiveField(3)
  late String time;
  @HiveField(4)
  late String status;
  @HiveField(5)
  late bool daniel;
  @HiveField(6)
  late bool leonard;
}