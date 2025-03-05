// task_list_viewmodel.dart
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:modern_todo/models/task.dart';
import 'package:modern_todo/repository/local/todo_hive_repository.dart';
import 'package:modern_todo/repository/todo_abstract_repository.dart';
import 'package:modern_todo/repository/repository_provider.dart';
import 'package:modern_todo/viewmodels/viewmodels_models/task_list_filter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_list_viewmodel.g.dart';

@riverpod
class TaskListViewModel extends _$TaskListViewModel {
  late final TodoAbstractRepository _repository;
  late final ValueListenable<Box<Task>> _listenable;
  late final VoidCallback _listener; // 리스너 콜백 인스턴스를 저장

  // 필터 조건을 적용하여 데이터를 가져오는 메서드
  Future<List<Task>> _fetchFilteredTasks(TaskListFilter filter) async {
    final tasks = await _repository.fetchTodos(date: filter.selectedDate);
    if (filter.selectedCategoryId != null) {
      return tasks
          .where((task) => task.categoryId == filter.selectedCategoryId)
          .toList();
    }
    return tasks;
  }

  // Hive Box의 데이터 변경 시 호출되는 리스너 메서드
  void _onTasksChanged(TaskListFilter filter) async {
    try {
      // 필터 조건을 적용한 데이터를 가져옵니다.
      final tasks = await _fetchFilteredTasks(filter);
      state = AsyncValue.data(tasks);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  @override
  Future<List<Task>> build(TaskListFilter filter) async {
    _repository = ref.watch(repositoryProviderProvider);
// Hive Repository인 경우 listenable 등록 (항상 등록)

    if (_repository is TodoHiveRepository) {
      final hiveRepo = _repository as TodoHiveRepository;
      _listenable = hiveRepo.taskBox.listenable();
      // _onTasksChanged에 필터 정보를 전달하기 위해 람다 함수로 감쌉니다.
      _listener = () => _onTasksChanged(filter);
      // provider가 dispose될 때 리스너를 해제합니다.
      _listenable.addListener(_listener);
      // provider가 dispose될 때 리스너를 해제합니다.
      ref.onDispose(() {
        _listenable.removeListener(_listener);
      });
    }

    // 초기 필터 조건을 적용한 데이터 반환
    return await _fetchFilteredTasks(filter);
  }

  Future<void> addTask(Task task) async {
    try {
      await _repository.addTodo(task);
      state = AsyncValue.data(await _repository.fetchTodos(date: task.date));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await _repository.updateTodo(task);
      state = AsyncValue.data(await _repository.fetchTodos(date: task.date));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteTask(Task task) async {
    try {
      await _repository.deleteTodo(task);
      state = AsyncValue.data(await _repository.fetchTodos(date: task.date));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  // 체크박스 토글 기능 추가: 완료 상태를 반전시킴
  Future<void> toggleTaskCompletion(Task task) async {
    try {
      final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
      await _repository.updateTodo(updatedTask);
      // 토글 후 해당 날짜의 작업들을 다시 불러옴
      state = AsyncValue.data(await _repository.fetchTodos(date: task.date));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
