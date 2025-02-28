import 'package:flutter_test/flutter_test.dart';
import 'package:modern_todo/models/task.dart';
import 'package:modern_todo/models/task_category.dart';
import 'package:modern_todo/repository/todo_abstract_repository.dart';
import 'package:modern_todo/repository/mock/todo_mock_repository.dart';

void main() {
  late TodoAbstractRepository repository;

  setUp(() {
    repository = TodoMockRepository();
  });

  test('fetchTodos 초기에는 빈 리스트를 반환해야 한다', () async {
    final tasks = await repository.fetchTodos();
    expect(tasks, isEmpty);
  });

  test('fetchCategories 초기에는 리스트를 반환해야 한다', () async {
    final tasks = await repository.fetchCategories();
    expect(tasks, isEmpty);
  });

  test('addTodo 후 fetchTodos로 추가된 작업을 확인할 수 있다', () async {
    final task =
        Task(id: 1, title: '테스트 작업', categoryId: 1, date: DateTime.now());
    await repository.addTodo(task);
    final tasks = await repository.fetchTodos();
    expect(tasks.length, 1);
    expect(tasks.first.title, equals('테스트 작업'));
  });

  test('updateTodo로 작업 수정이 가능해야 한다', () async {
    final task =
        Task(id: 1, title: '원본 작업', categoryId: 1, date: DateTime.now());
    await repository.addTodo(task);

    final updatedTask =
        Task(id: 1, title: '수정된 작업', categoryId: 1, date: DateTime.now());
    await repository.updateTodo(updatedTask);

    final tasks = await repository.fetchTodos();
    expect(tasks.first.title, equals('수정된 작업'));
  });

  test('deleteTodo 후 작업 목록에서 삭제되어야 한다', () async {
    final task =
        Task(id: 1, title: '삭제 테스트', categoryId: 1, date: DateTime.now());
    await repository.addTodo(task);
    await repository.deleteTodo(task);

    final tasks = await repository.fetchTodos();
    expect(tasks, isEmpty);
  });

  test('fetchCategories가 올바른 카테고리 목록을 반환해야 한다', () async {
    final categories = await repository.fetchCategories();
    // 예를 들어, 기본 데이터로 미리 등록된 카테고리가 있다면 그 개수를 확인합니다.
    expect(categories, isNotNull);
    expect(categories, isNotEmpty);
  });

  test('fetchCategoryById가 올바른 카테고리를 반환해야 한다', () async {
    final categories = await repository.fetchCategories();
    final firstCategory = categories.first;
    final fetchedCategory =
        await repository.fetchCategoryById(firstCategory.id);
    expect(fetchedCategory?.id, equals(firstCategory.id));
  });
}
