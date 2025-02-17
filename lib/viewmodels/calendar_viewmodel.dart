import 'package:modern_todo/models/todo_item.dart';
import 'package:modern_todo/repository/todo_abstract_repository.dart';
import 'package:modern_todo/repository/todo_mock_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'calendar_viewmodel.g.dart';

@riverpod
class CalendarViewModel extends _$CalendarViewModel {
  late final TodoAbstractRepository _repository;

  @override
  Future<List<TodoItem>> build() async {
    // Repository Provider로부터 TodoAbstractRepository 인스턴스를 가져옵니다.
    _repository = ref.watch(todoMockRepositoryProvider);
    // 초기 로딩 시 전체 일정을 반환합니다.
    return await _repository.fetchTodos();
  }

  /// 오늘의 일정을 불러옵니다.
  Future<List<TodoItem>> fetchTodayTodos() async {
    final today = DateTime.now();
    return await _repository.fetchTodos(date: today);
  }

  /// 내일의 일정을 불러옵니다.
  Future<List<TodoItem>> fetchTomorrowTodos() async {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return await _repository.fetchTodos(date: tomorrow);
  }

  /// 전체 일정을 불러옵니다.
  Future<List<TodoItem>> fetchAllTodos() async {
    return await _repository.fetchTodos();
  }

  /// 새로운 Todo 항목을 추가한 후, 전체 일정을 새로 불러옵니다.
  Future<void> addTodo(TodoItem todo) async {
    try {
      await _repository.addTodo(todo);
      // 추가 후 전체 일정 다시 불러오기
      state = AsyncValue.data(await _repository.fetchTodos());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// 기존 Todo 항목을 삭제한 후, 전체 일정을 새로 불러옵니다.
  Future<void> deleteTodo(TodoItem todo) async {
    try {
      await _repository.deleteTodo(todo);
      state = AsyncValue.data(await _repository.fetchTodos());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// 기존 Todo 항목을 수정한 후, 전체 일정을 새로 불러옵니다.
  Future<void> updateTodo(TodoItem todo) async {
    try {
      await _repository.updateTodo(todo);
      state = AsyncValue.data(await _repository.fetchTodos());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
