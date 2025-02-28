import 'dart:async';
import 'package:modern_todo/data/mock_data.dart';
import 'package:modern_todo/models/task.dart';
import 'package:modern_todo/models/task_category.dart';
import 'package:collection/collection.dart';
import '../todo_abstract_repository.dart';

class TodoMockRepository implements TodoAbstractRepository {
  // 메모리 내 저장소 (초기에는 빈 리스트, 필요하다면 초기 목(mock) 데이터를 추가 가능)
  final List<Task> _tasks = [];
  final List<TaskCategory> _taskcategorys = [];

  TodoMockRepository() {
    // 미리 준비된 mockTasks와 mockCategorys 데이터를 내부 리스트에 추가
    _tasks.addAll(mockTasks);
    _taskcategorys.addAll(mockCategorys);
  }

  @override
  Future<List<Task>> fetchTodos({DateTime? date}) async {
    // date가 null이면 모든 작업을 반환
    if (date == null) {
      return _tasks;
    } else {
      // date가 주어지면, 해당 날짜(연/월/일)가 일치하는 작업만 필터링하여 반환
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
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
    } else {
      throw Exception("해당 Task를 찾을 수 없습니다.");
    }
  }

  @override
  Future<void> deleteTodo(Task task) async {
    _tasks.removeWhere((t) => t.id == task.id);
  }

  @override
  Future<List<TaskCategory>> fetchCategories() async {
    // 메모리에 저장해 둔 _taskcategorys 리스트 반환
    return _taskcategorys;
  }

  // 주어진 ID로 카테고리를 찾는 메서드
  @override
  Future<TaskCategory?> fetchCategoryById(int id) async {
    return _taskcategorys.firstWhereOrNull((cat) => cat.id == id);
  }
}
