import 'package:hive/hive.dart';
part 'recipe_model.g.dart';

@HiveType(typeId: 4)
class RecipeModel extends HiveObject{
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String description;
  @HiveField(2)
  late String image;
  @HiveField(3)
  late String rating;
  @HiveField(4)
  late String ingredients;
  @HiveField(5)
  late String time;
}