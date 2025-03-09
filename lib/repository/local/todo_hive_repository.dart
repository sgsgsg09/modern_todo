import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:modern_todo/core/theme/color_palette.dart';
import 'package:modern_todo/models/task.dart';
import 'package:modern_todo/models/task_category.dart';
import 'package:modern_todo/repository/todo_abstract_repository.dart';

class TodoHiveRepository implements TodoAbstractRepository {
  final Box<Task> taskBox;
  final List<TaskCategory> _taskcategorys = [
    TaskCategory(
      id: 1,
      name: "Todo",
      colorValue: AppColors.CategoryTodo.value,
    ),
  TaskCategory(
      id: 2,
      name: "Other",
      colorValue: AppColors.CategoryRoutine.value,
    ),
  ];
  TodoHiveRepository(this.taskBox);

  @override
  Future<List<Task>> fetchTodos({DateTime? date}) async {
    final tasks = taskBox.values.toList();
    List<Task> filteredTasks;

    if (date != null) {
      filteredTasks = tasks
          .where((task) =>
              task.date.year == date.year &&
              task.date.month == date.month &&
              task.date.day == date.day)
          .toList();
    } else {
      filteredTasks = tasks;
    }

    // startTime이 null인 경우는 뒤쪽에 배치
    filteredTasks.sort((a, b) {
      if (a.startTime == null && b.startTime == null) return 0;
      if (a.startTime == null) return 1;
      if (b.startTime == null) return -1;
      final aMinutes = a.startTime!.hour * 60 + a.startTime!.minute;
      final bMinutes = b.startTime!.hour * 60 + b.startTime!.minute;
      return aMinutes.compareTo(bMinutes);
    });

    return filteredTasks;
  }

  @override
  Future<void> addTodo(Task task) async {
    // id가 null이면 auto-increment 시뮬레이션 (Mock Repository와 동일한 방식)
    final tasks = taskBox.values.toList();
    final newId = tasks.isEmpty
        ? 1
        : tasks.map((t) => t.id ?? 0).reduce((a, b) => a > b ? a : b) + 1;
    final newTask = task.copyWith(id: newId);
    await taskBox.add(newTask);
  }

  @override
  Future<void> updateTodo(Task task) async {
    // Hive의 key를 통해 update 처리
    for (var key in taskBox.keys) {
      final item = taskBox.get(key);
      if (item?.id == task.id) {
        await taskBox.put(key, task);
        return;
      }
    }
    throw Exception("해당 Task를 찾을 수 없습니다.");
  }

  @override
  Future<void> deleteTodo(Task task) async {
    // Hive의 key를 통해 delete 처리
    for (var key in taskBox.keys) {
      final item = taskBox.get(key);
      if (item?.id == task.id) {
        await taskBox.delete(key);
        return;
      }
    }
    throw Exception("해당 Task를 찾을 수 없습니다.");
  }

  @override
  Future<List<TaskCategory>> fetchCategories() async {
    return _taskcategorys;
  }

  @override
  Future<TaskCategory?> fetchCategoryById(int id) async {
    return _taskcategorys.firstWhereOrNull((cat) => cat.id == id);
  }

  // 네트워크 동기화와 관련된 uploadTodo는 여기서 별도 구현하지 않음.
}
