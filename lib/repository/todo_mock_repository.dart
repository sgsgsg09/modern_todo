import 'dart:async';
import 'package:modern_todo/models/todo_item.dart';
import 'todo_abstract_repository.dart';

class TodoMockRepository implements TodoAbstractRepository {
  // 메모리 내 저장소 (초기에는 빈 리스트, 필요하면 초기 목 데이터를 넣을 수 있음)
  final List<TodoItem> _todos = [];

  @override
  Future<List<TodoItem>> fetchTodos({DateTime? date}) async {
    // 딜레이를 주어 네트워크 호출과 유사하게 동작하도록 함
    await Future.delayed(Duration(milliseconds: 500));
    if (date == null) {
      return _todos;
    } else {
      // 날짜가 일치하는 항목만 반환 (날짜만 비교)
      return _todos.where((todo) {
        return todo.startDate.year == date.year &&
            todo.startDate.month == date.month &&
            todo.startDate.day == date.day;
      }).toList();
    }
  }

  @override
  Future<void> addTodo(TodoItem todo) async {
    await Future.delayed(Duration(milliseconds: 300));
    // id가 null이면 auto-increment 시뮬레이션
    final newId = _todos.isEmpty
        ? 1
        : _todos.map((t) => t.id ?? 0).reduce((a, b) => a > b ? a : b) + 1;
    final newTodo = todo.copyWith(id: newId);
    _todos.add(newTodo);
  }

  @override
  Future<void> updateTodo(TodoItem todo) async {
    await Future.delayed(Duration(milliseconds: 300));
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
    } else {
      throw Exception("Todo not found");
    }
  }

  @override
  Future<void> deleteTodo(TodoItem todo) async {
    await Future.delayed(Duration(milliseconds: 300));
    _todos.removeWhere((t) => t.id == todo.id);
  }
}
