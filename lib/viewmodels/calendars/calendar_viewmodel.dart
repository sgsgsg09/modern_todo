// calendar_viewmodel.dart
import 'package:modern_todo/models/task.dart';
import 'package:modern_todo/repository/todo_abstract_repository.dart';
import 'package:modern_todo/repository/repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:table_calendar/table_calendar.dart';

part 'calendar_viewmodel.g.dart';

@riverpod
class CalendarViewModel extends _$CalendarViewModel {
  late final TodoAbstractRepository _repository;

  @override
  Future<List<Task>> build() async {
    // Repository Provider로부터 Task 관련 인스턴스를 가져옵니다.
    _repository = ref.watch(repositoryProviderProvider);
    // 초기 로딩 시 전체 일정을 반환합니다.
    return await _repository.fetchTodos();
  }

  /// 선택된 날짜에 해당하는 Task 목록을 반환하는 정적 유틸리티 메서드
  static List<Task> getEventsForDay(DateTime day, List<Task> tasks) {
    return tasks.where((task) => isSameDay(task.date, day)).toList();
  }

  Future<void> addTask(Task task) async {
    try {
      await _repository.addTodo(task);
      final tasks = await _repository.fetchTodos();
      state = AsyncValue.data(tasks);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await _repository.updateTodo(task);
      final tasks = await _repository.fetchTodos();
      state = AsyncValue.data(tasks);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deleteTask(Task task) async {
    try {
      await _repository.deleteTodo(task);
      final tasks = await _repository.fetchTodos();
      state = AsyncValue.data(tasks);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
