import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:modern_todo/models/todo_item.dart';
import 'package:modern_todo/repository/todo_abstract_repository.dart';

class TodoNetworkRepository implements TodoAbstractRepository {
  // API 서버의 기본 URL (실제 사용하는 URL로 변경)
  final String baseUrl;

  TodoNetworkRepository({this.baseUrl = 'https://api.example.com'});

  @override
  Future<List<TodoItem>> fetchTodos({DateTime? date}) async {
    final response = await http.get(Uri.parse('$baseUrl/todos'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      List<TodoItem> todos = jsonData
          .map((data) => TodoItem.fromJson(data as Map<String, dynamic>))
          .toList();

      // 날짜 필터링 (옵션)
      if (date != null) {
        todos = todos.where((todo) {
          return todo.startDate.year == date.year &&
              todo.startDate.month == date.month &&
              todo.startDate.day == date.day;
        }).toList();
      }
      return todos;
    } else {
      throw Exception('Failed to load todos');
    }
  }

  @override
  Future<void> addTodo(TodoItem todo) async {
    final response = await http.post(
      Uri.parse('$baseUrl/todos'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(todo.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add todo');
    }
  }

  @override
  Future<void> updateTodo(TodoItem todo) async {
    final response = await http.put(
      Uri.parse('$baseUrl/todos/${todo.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(todo.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update todo');
    }
  }

  @override
  Future<void> deleteTodo(TodoItem todo) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/todos/${todo.id}'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete todo');
    }
  }

  @override
  Future<void> uploadTodo(TodoItem todo) async {
    // uploadTodo가 addTodo와 동일한 동작을 한다고 가정할 경우
    await addTodo(todo);
  }

  @override
  Future<List<TodoItem>> fetchTodo(DateTime? date) async {
    // fetchTodo와 fetchTodos가 유사한 역할을 한다면 아래와 같이 위임할 수 있습니다.
    return fetchTodos(date: date);
  }
}
