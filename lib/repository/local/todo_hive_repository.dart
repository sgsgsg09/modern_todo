import 'package:hive/hive.dart';
import 'package:modern_todo/models/task.dart';
import 'package:modern_todo/models/task_category.dart';
import 'package:modern_todo/repository/todo_abstract_repository.dart';

class TodoHiveRepository implements TodoAbstractRepository {
  final Box<Task> box;

  TodoHiveRepository(this.box);

  @override
  Future<List<Task>> fetchTodos({DateTime? date}) async {
    final tasks = box.values.toList();
    if (date != null) {
      return tasks
          .where((task) =>
              task.date.year == date.year &&
              task.date.month == date.month &&
              task.date.day == date.day)
          .toList();
    }
    return tasks;
  }

  @override
  Future<void> addTodo(Task task) async {
    await box.add(task);
  }

  @override
  Future<void> updateTodo(Task task) async {
    // Hive의 key는 내부적으로 관리되므로, update를 위해 key를 찾음
    for (var key in box.keys) {
      final item = box.get(key);
      if (item?.id == task.id) {
        await box.put(key, task);
        return;
      }
    }
  }

  @override
  Future<void> deleteTodo(Task task) async {
    for (var key in box.keys) {
      final item = box.get(key);
      if (item?.id == task.id) {
        await box.delete(key);
        return;
      }
    }
  }

  @override
  Future<List<TaskCategory>> fetchCategories() {
    // TODO: implement fetchCategories
    throw UnimplementedError();
  }

  @override
  Future<TaskCategory?> fetchCategoryById(int id) {
    // TODO: implement fetchCategoryById
    throw UnimplementedError();
  }

  // 네트워크 동기화와 관련된 uploadTodo는 여기서 별도 구현하지 않음.
}
