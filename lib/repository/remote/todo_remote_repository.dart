import 'package:modern_todo/models/todo_item.dart';
import 'package:modern_todo/repository/todo_abstract_repository.dart';

class TodoRemoteRepository implements TodoAbstractRepository {
  @override
  Future<List<TodoItem>> fetchTodos({DateTime? date}) async {
    // 네트워크 호출 시뮬레이션
    await Future.delayed(Duration(milliseconds: 500));
    // 실제 API 호출 후 JSON 파싱 로직 구현
    return [];
  }

  @override
  Future<void> addTodo(TodoItem todo) async {
    await Future.delayed(Duration(milliseconds: 500));
    print("Remote: Todo added.");
  }

  @override
  Future<void> updateTodo(TodoItem todo) async {
    await Future.delayed(Duration(milliseconds: 500));
    print("Remote: Todo updated.");
  }

  @override
  Future<void> deleteTodo(TodoItem todo) async {
    await Future.delayed(Duration(milliseconds: 500));
    print("Remote: Todo deleted.");
  }
}
