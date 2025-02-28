import 'package:modern_todo/models/task.dart';
import 'package:modern_todo/models/task_category.dart';
import 'package:modern_todo/repository/todo_abstract_repository.dart';
import 'package:modern_todo/repository/repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:table_calendar/table_calendar.dart';

part 'categories_viewmodel.g.dart';

@riverpod
class CategoriesViewmodel extends _$CategoriesViewmodel {
  late final TodoAbstractRepository _repository;

  //fetchCateories를 통해 리스트 목록을 알아냄.
  @override
  Future<List<TaskCategory>> build() async {
    _repository = ref.watch(repositoryProviderProvider);

    return await _repository.fetchCategories();
  }
}
