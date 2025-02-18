// repository_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo/repository/mock/todo_mock_repository.dart';
import 'package:modern_todo/repository/todo_abstract_repository.dart';

// TodoAbstractRepository의 구현체로 TodoMockRepository를 사용
final todoRepositoryProvider = Provider<TodoAbstractRepository>((ref) {
  return TodoMockRepository();
});
