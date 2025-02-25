// task_detail_viewmodel.dart
import 'package:modern_todo/models/task.dart';
import 'package:modern_todo/repository/todo_abstract_repository.dart';
import 'package:modern_todo/repository/repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_detail_viewmodel.g.dart';

@riverpod
class TaskDetailViewModel extends _$TaskDetailViewModel {
  late final TodoAbstractRepository _repository;

  // 초기 Task 데이터를 받아 상태를 설정합니다.
  @override
  Future<Task> build(Task initialTask) async {
    _repository = ref.watch(repositoryProviderProvider);
    // 필요 시 Repository에서 최신 데이터를 가져올 수 있지만, 여기서는 initialTask 반환
    return initialTask;
  }

  Future<void> updateTask(Task updatedTask) async {
    try {
      await _repository.updateTodo(updatedTask);
      state = AsyncValue.data(updatedTask);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteTask(Task task) async {
    try {
      await _repository.deleteTodo(task);
      // 삭제 후 상태 처리는 화면 로직에 맞게 처리
      state = AsyncValue.data(task);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
