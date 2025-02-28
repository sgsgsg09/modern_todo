// task_list_viewmodel.dart
import 'package:modern_todo/models/task.dart';
import 'package:modern_todo/repository/todo_abstract_repository.dart';
import 'package:modern_todo/repository/repository_provider.dart';
import 'package:modern_todo/viewmodels/viewmodels_models/task_list_filter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_list_viewmodel.g.dart';

@riverpod
class TaskListViewModel extends _$TaskListViewModel {
  late final TodoAbstractRepository _repository;

  @override
  Future<List<Task>> build(TaskListFilter filter) async {
    _repository = ref.watch(repositoryProviderProvider);
    // 날짜 기준으로 작업 불러오기
    final tasks = await _repository.fetchTodos(date: filter.selectedDate);

    // 선택된 카테고리가 있다면 해당 카테고리로 필터링 (Task 모델에 categoryId 필드가 있다고 가정)
    if (filter.selectedCategoryId != null) {
      return tasks
          .where((task) => task.categoryId == filter.selectedCategoryId)
          .toList();
    }
    return tasks;
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
