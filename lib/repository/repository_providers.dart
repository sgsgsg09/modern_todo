import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'todo_abstract_repository.dart';
import 'todo_local_repository.dart';

part 'repository_providers.g.dart';

/// SharedPreferences 인스턴스를 제공하는 Provider
@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(Ref ref) async {
  return await SharedPreferences.getInstance();
}

/// TodoAbstractRepository의 로컬 구현체를 제공하는 Provider
@Riverpod(keepAlive: true)
Future<TodoAbstractRepository> todoRepository(Ref ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return TodoLocalRepository(prefs);
}
