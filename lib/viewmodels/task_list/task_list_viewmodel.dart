// task_list_viewmodel.dart
import 'package:modern_todo/models/task.dart';
import 'package:modern_todo/models/task_category.dart';
import 'package:modern_todo/repository/todo_abstract_repository.dart';
import 'package:modern_todo/repository/repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_list_viewmodel.g.dart';

/// 작업 목록 필터링에 사용할 파라미터 클래스
class TaskListFilter {
  final DateTime selectedDate;
  final TaskCategory? selectedCategory;

  TaskListFilter({required this.selectedDate, this.selectedCategory});
}

@riverpod
class TaskListViewModel extends _$TaskListViewModel {
  late final TodoAbstractRepository _repository;

  /// family 파라미터로 TaskListFilter를 받아 선택된 날짜와 카테고리에 따라 작업 목록을 필터링합니다.
  @override
  Future<List<Task>> build(TaskListFilter filter) async {
    _repository = ref.watch(repositoryProviderProvider);
    final tasks = await _repository.fetchTodos(date: filter.selectedDate);
    if (filter.selectedCategory != null) {
      return tasks
          .where((task) => task.category.id == filter.selectedCategory!.id)
          .toList();
    }
    return tasks;
  }

  Future<void> addTask(Task task, TaskListFilter filter) async {
    try {
      await _repository.addTodo(task);
      final tasks = await _repository.fetchTodos(date: filter.selectedDate);
      if (filter.selectedCategory != null) {
        state = AsyncValue.data(tasks
            .where((t) => t.category.id == filter.selectedCategory!.id)
            .toList());
      } else {
        state = AsyncValue.data(tasks);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateTask(Task task, TaskListFilter filter) async {
    try {
      await _repository.updateTodo(task);
      final tasks = await _repository.fetchTodos(date: filter.selectedDate);
      if (filter.selectedCategory != null) {
        state = AsyncValue.data(tasks
            .where((t) => t.category.id == filter.selectedCategory!.id)
            .toList());
      } else {
        state = AsyncValue.data(tasks);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteTask(Task task, TaskListFilter filter) async {
    try {
      await _repository.deleteTodo(task);
      final tasks = await _repository.fetchTodos(date: filter.selectedDate);
      if (filter.selectedCategory != null) {
        state = AsyncValue.data(tasks
            .where((t) => t.category.id == filter.selectedCategory!.id)
            .toList());
      } else {
        state = AsyncValue.data(tasks);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
