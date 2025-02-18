import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo/models/todo_item.dart';
import 'package:modern_todo/repository/todo_abstract_repository.dart';
import 'package:modern_todo/repository/repository_provider.dart';

/// todoViewModelProvider는 repositoryProvider로부터 주입받은 구현체를 사용합니다.
final todoViewModelProvider =
    StateNotifierProvider<TodoViewModel, AsyncValue<List<TodoItem>>>((ref) {
  // repositoryProvider에서 구현체를 가져옵니다.
  final repository = ref.watch(todoRepositoryProvider);
  return TodoViewModel(repository);
});

class TodoViewModel extends StateNotifier<AsyncValue<List<TodoItem>>> {
  final TodoAbstractRepository repository;

  TodoViewModel(this.repository) : super(const AsyncValue.loading()) {
    loadTodos();
  }

  /// 외부 데이터 소스로부터 Todo 목록을 로드합니다.
  Future<void> loadTodos() async {
    try {
      final todos = await repository.fetchTodos();
      state = AsyncValue.data(todos);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// 새 Todo 추가
  Future<void> addTodo(TodoItem todo) async {
    await repository.addTodo(todo);
    await loadTodos();
  }

  /// Todo 수정
  Future<void> updateTodo(TodoItem todo) async {
    await repository.updateTodo(todo);
    await loadTodos();
  }

  /// Todo 삭제
  Future<void> deleteTodo(TodoItem todo) async {
    await repository.deleteTodo(todo);
    await loadTodos();
  }
}
