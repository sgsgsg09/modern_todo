// calendar_viewmodel.dart
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:modern_todo/models/task.dart';
import 'package:modern_todo/repository/local/todo_hive_repository.dart';
import 'package:modern_todo/repository/todo_abstract_repository.dart';
import 'package:modern_todo/repository/repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:table_calendar/table_calendar.dart';

part 'calendar_viewmodel.g.dart';

@riverpod
class CalendarViewModel extends _$CalendarViewModel {
  late final TodoAbstractRepository _repository;
  late final ValueListenable<Box<Task>> _listenable;

  @override
  Future<List<Task>> build() async {
    // Repository Provider로부터 Task 관련 인스턴스를 가져옵니다.
    _repository = ref.watch(repositoryProviderProvider);

    // Hive Repository인 경우, listenable 설정
    if (_repository is TodoHiveRepository) {
      final hiveRepo = _repository as TodoHiveRepository;
      _listenable = hiveRepo.taskBox.listenable();
      _listenable.addListener(_onTasksChanged);
      // 클린업 작업 등록: provider가 dispose될 때 리스너를 해제합니다.
      ref.onDispose(() {
        _listenable.removeListener(_onTasksChanged);
      });
    }

    // 초기 로딩 시 전체 일정을 반환합니다.
    return await _repository.fetchTodos();
  }

  // Hive Box의 데이터 변경 시 호출되는 리스너 메서드
  void _onTasksChanged() async {
    try {
      final tasks = await _repository.fetchTodos();
      state = AsyncValue.data(tasks);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// 선택된 날짜에 해당하는 Task 목록을 반환하는 정적 유틸리티 메서드
  static List<Task> getEventsForDay(DateTime day, List<Task> tasks) {
    return tasks.where((task) => isSameDay(task.date, day)).toList();
  }

  Future<void> addTask(Task task) async {
    try {
      await _repository.addTodo(task);
      // addTodo 이후 listenable이 자동으로 _onTasksChanged 호출됨
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await _repository.updateTodo(task);
      // updateTodo 이후 listenable이 자동으로 _onTasksChanged 호출됨
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deleteTask(Task task) async {
    try {
      await _repository.deleteTodo(task);
      // deleteTodo 이후 listenable이 자동으로 _onTasksChanged 호출됨
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
