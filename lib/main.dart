import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:modern_todo/adapters/task_hive_adapter.dart';
import 'package:modern_todo/models/task.dart';
import 'package:modern_todo/repository/repository_provider.dart';
import 'package:modern_todo/views/calendar_view.dart';
import 'package:modern_todo/views/todo_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TaskHiveAdapter());
  // Box<TodoItem>를 열어두자.
  await Hive.openBox<Task>('todos');

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Modern Todo',
      home: Scaffold(
        body: SafeArea(child: const TodoView()),
      ),
    );
  }
}
