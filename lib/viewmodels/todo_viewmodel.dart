import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo/models/todo_item.dart';

/// TodoViewModel이 관리하는 상태: AsyncValue<List<TodoItem>>
final todoViewModelProvider =
    StateNotifierProvider<TodoViewModel, AsyncValue<List<TodoItem>>>((ref) {
  return TodoViewModel();
});

class TodoViewModel extends StateNotifier<AsyncValue<List<TodoItem>>> {
  // 메모리 상에서 관리할 Todo 목록
  final List<TodoItem> _todos = [];

  TodoViewModel() : super(const AsyncValue.loading()) {
    _initLoad();
  }

  /// 초기 데이터 로딩 (여기서는 지연 후 빈 목록으로 설정)
  Future<void> _initLoad() async {
    await Future.delayed(const Duration(milliseconds: 500));
    state = AsyncValue.data(_todos);
  }

  /// 새 Todo 추가
  Future<void> addTodo(TodoItem todo) async {
    // 임의로 ID를 부여 (실제 DB 사용 시 DB에서 생성)
    final newId = _todos.isEmpty
        ? 1
        : (_todos.map((e) => e.id ?? 0).reduce((a, b) => a > b ? a : b) + 1);
    final newTodo = todo.copyWith(id: newId);
    _todos.add(newTodo);
    state = AsyncValue.data([..._todos]); // 변경된 목록 반영
  }

  /// Todo 수정 (id가 같은 항목 찾아서 교체)
  Future<void> updateTodo(TodoItem updated) async {
    final index = _todos.indexWhere((t) => t.id == updated.id);
    if (index != -1) {
      _todos[index] = updated;
      state = AsyncValue.data([..._todos]);
    }
  }

  /// Todo 삭제
  Future<void> deleteTodo(TodoItem target) async {
    _todos.removeWhere((t) => t.id == target.id);
    state = AsyncValue.data([..._todos]);
  }
}
