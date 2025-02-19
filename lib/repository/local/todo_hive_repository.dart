import 'package:hive/hive.dart';
import 'package:modern_todo/models/todo_item.dart';
import 'package:modern_todo/repository/todo_abstract_repository.dart';

class TodoHiveRepository implements TodoAbstractRepository {
  final Box<TodoItem> box;

  TodoHiveRepository(this.box);

  @override
  Future<List<TodoItem>> fetchTodos({DateTime? date}) async {
    final todos = box.values.toList();
    if (date != null) {
      return todos
          .where((todo) =>
              todo.startDate.year == date.year &&
              todo.startDate.month == date.month &&
              todo.startDate.day == date.day)
          .toList();
    }
    return todos;
  }

  @override
  Future<void> addTodo(TodoItem todo) async {
    await box.add(todo);
  }

  @override
  Future<void> updateTodo(TodoItem todo) async {
    // Hive의 key는 내부적으로 관리되므로, update를 위해 key를 찾음
    for (var key in box.keys) {
      final item = box.get(key);
      if (item?.id == todo.id) {
        await box.put(key, todo);
        return;
      }
    }
  }

  @override
  Future<void> deleteTodo(TodoItem todo) async {
    for (var key in box.keys) {
      final item = box.get(key);
      if (item?.id == todo.id) {
        await box.delete(key);
        return;
      }
    }
  }

  // 기존의 uploadTodo는 네트워크 동기화 관리에서 다루므로 여기에선 별도 구현하지 않음.
}
