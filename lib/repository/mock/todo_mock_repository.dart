import 'dart:async';
import 'package:modern_todo/data/mock_data.dart';
import 'package:modern_todo/models/task.dart';
import 'package:modern_todo/models/task_category.dart';
import '../todo_abstract_repository.dart';

class TodoMockRepository implements TodoAbstractRepository {
  // 메모리 내 저장소 (초기에는 빈 리스트, 필요하면 초기 목 데이터를 넣을 수 있음)
  final List<Task> _tasks = [];

  TodoMockRepository() {
    _tasks.addAll((mockTasks));
  }

  @override
  Future<List<Task>> fetchTodos({DateTime? date}) async {
    // 딜레이를 주어 네트워크 호출과 유사하게 동작하도록 함
    if (date == null) {
      return _tasks;
    } else {
      // 날짜가 일치하는 항목만 반환 (날짜만 비교)
      return _tasks.where((task) {
        return task.date.year == date.year &&
            task.date.month == date.month &&
            task.date.day == date.day;
      }).toList();
    }
  }

  @override
  Future<void> addTodo(Task task) async {
    // id가 null이면 auto-increment 시뮬레이션
    final newId = _tasks.isEmpty
        ? 1
        : _tasks.map((t) => t.id ?? 0).reduce((a, b) => a > b ? a : b) + 1;
    final newTask = task.copyWith(id: newId);
    _tasks.add(newTask);
  }

  @override
  Future<void> updateTodo(Task task) async {
    await Future.delayed(Duration(milliseconds: 300));
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
    } else {
      throw Exception("Task not found");
    }
  }

  @override
  Future<void> deleteTodo(Task task) async {
    await Future.delayed(Duration(milliseconds: 300));
    _tasks.removeWhere((t) => t.id == task.id);
  }
}
