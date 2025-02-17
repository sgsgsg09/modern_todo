// TODO Implement this library.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'todo_mock_repository.dart';
import 'todo_abstract_repository.dart';

part 'todo_mock_repository_provider.g.dart';

@Riverpod(keepAlive: true)
TodoAbstractRepository todoMockRepository(Ref ref) {
  return TodoMockRepository();
}
