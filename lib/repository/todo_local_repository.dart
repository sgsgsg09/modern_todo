import 'dart:convert';
import 'package:modern_todo/models/todo_item.dart';
import 'package:modern_todo/repository/todo_abstract_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoLocalRepository implements TodoAbstractRepository {
  final SharedPreferences prefs;
  final String _key = 'todos';

  TodoLocalRepository(this.prefs);

  @override
  Future<List<TodoItem>> fetchTodo(DateTime? date) async {
    // SharedPreferences에 저장된 JSON 문자열 리스트를 가져옵니다.
    final jsonStringList = prefs.getStringList(_key) ?? [];
    final todos = jsonStringList
        .map((jsonString) => TodoItem.fromJson(jsonDecode(jsonString)))
        .toList();

    // 날짜 필터가 있다면 해당 날짜의 항목만 반환합니다.
    if (date != null) {
      return todos.where((todo) {
        return todo.startDate.year == date.year &&
            todo.startDate.month == date.month &&
            todo.startDate.day == date.day;
      }).toList();
    }
    return todos;
  }

  @override
  Future<void> uploadTodo(TodoItem todo) async {
    // 전체 목록을 가져온 후 새 항목을 추가합니다.
    final todos = await fetchTodo(null);
    todos.add(todo);

    // 다시 JSON 문자열 리스트로 변환하여 저장합니다.
    final jsonStringList =
        todos.map((todo) => jsonEncode(todo.toJson())).toList();
    await prefs.setStringList(_key, jsonStringList);
  }

  @override
  Future<void> deleteTodo(TodoItem todo) {
    // TODO: implement deleteTodo
    throw UnimplementedError();
  }

  @override
  Future<void> addTodo(TodoItem todo) {
    // TODO: implement addTodo
    throw UnimplementedError();
  }

  @override
  Future<List<TodoItem>> fetchTodos({DateTime? date}) {
    // TODO: implement fetchTodos
    throw UnimplementedError();
  }

  @override
  Future<void> updateTodo(TodoItem todo) {
    // TODO: implement updateTodo
    throw UnimplementedError();
  }
}
