import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'todo_local_repository.dart';
import '../todo_abstract_repository.dart';

part 'todo_local_repository_provider.g.dart';

@Riverpod(keepAlive: true)
Future<TodoAbstractRepository> todoLocalRepository(Ref ref) async {
  final prefs = await SharedPreferences.getInstance();
  return TodoLocalRepository(prefs);
}
