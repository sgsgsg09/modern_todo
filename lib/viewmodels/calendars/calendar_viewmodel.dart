// calendar_viewmodel.dart
import 'package:modern_todo/models/task.dart';
import 'package:modern_todo/repository/todo_abstract_repository.dart';
import 'package:modern_todo/repository/repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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

  Future<List<Task>> fetchTodayTasks() async {
    final today = DateTime.now();
    return await _repository.fetchTodos(date: today);
  }
  /*
  내일 불러오는 것은 필요 없다고 느낌. 
  Future<List<Task>> fetchTomorrowTasks() async {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return await _repository.fetchTodos(date: tomorrow);
  } */

  Future<void> addTask(Task task) async {
    try {
      await _repository.addTodo(task);
      state = AsyncValue.data(await _repository.fetchTodos());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await _repository.updateTodo(task);
      state = AsyncValue.data(await _repository.fetchTodos());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteTask(Task task) async {
    try {
      await _repository.deleteTodo(task);
      state = AsyncValue.data(await _repository.fetchTodos());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
