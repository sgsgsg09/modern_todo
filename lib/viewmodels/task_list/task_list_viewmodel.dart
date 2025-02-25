// task_list_viewmodel.dart
import 'package:modern_todo/models/task.dart';
import 'package:modern_todo/models/task_category.dart';
import 'package:modern_todo/repository/todo_abstract_repository.dart';
import 'package:modern_todo/repository/repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_list_viewmodel.g.dart';

@riverpod
class TaskListViewModel extends _$TaskListViewModel {
  late final TodoAbstractRepository _repository;

  // family 파라미터를 사용해 선택된 날짜에 해당하는 Task 목록을 로드합니다.
  @override
  Future<List<Task>> build(DateTime selectedDate) async {
    _repository = ref.watch(repositoryProviderProvider);
    return await _repository.fetchTodos(date: selectedDate);
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

  Future<List<Task>> fetchTasksByCategory(TaskCategory category) async {
    final allTasks = await _repository.fetchTodos();
    return allTasks.where((task) => task.category == category).toList();
  }
}
