import 'package:hive/hive.dart';

part 'task_category.g.dart';

@HiveType(typeId: 1)
class TaskCategory extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int colorValue;

  TaskCategory({
    required this.id,
    required this.name,
    required this.colorValue,
  });
}
