// TODO Implement this library.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo/repository/mock/todo_mock_repository.dart';
import 'package:modern_todo/repository/todo_abstract_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repository_provider.g.dart';

@Riverpod(keepAlive: true)
TodoAbstractRepository repositoryProvider(Ref ref) {
  return TodoMockRepository();
}
