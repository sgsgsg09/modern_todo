import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo/repository/repository_provider.dart';
import 'package:modern_todo/views/calendar_view.dart';
import 'package:modern_todo/views/todo_view.dart';

void main() {
  // Hive 초기화 등 필요한 초기화 작업을 수행
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(todoRepositoryProvider);

    return MaterialApp(
      title: 'Modern Todo',
      home: Scaffold(
        body: const TodoView(),
      ),
    );
  }
}
