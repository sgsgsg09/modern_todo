// TODO Implement this library.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:modern_todo/models/task.dart';
import 'package:modern_todo/repository/local/todo_hive_repository.dart';
import 'package:modern_todo/repository/mock/todo_mock_repository.dart';
import 'package:modern_todo/repository/todo_abstract_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repository_provider.g.dart';

@Riverpod(keepAlive: true)
TodoAbstractRepository repositoryProvider(Ref ref) {
  // 환경 변수 'USE_MOCK_REPO'가 true로 설정되었으면 모의(Mock) 저장소를 사용합니다.
  const bool useMockRepo = bool.fromEnvironment(
    'USE_MOCK_REPO',
    defaultValue: false,
  );

  if (useMockRepo) {
    return TodoMockRepository();
  } else {
    final taskBox = Hive.box<Task>('tasks');
    return TodoHiveRepository(taskBox);
  }
}
