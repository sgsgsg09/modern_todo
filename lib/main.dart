import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:modern_todo/adapters/task_hive_adapter.dart';
import 'package:modern_todo/core/theme/color_palette.dart';
import 'package:modern_todo/models/task.dart';
import 'package:modern_todo/views/calendar_view.dart';

import 'package:modern_todo/views/todo_view.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

// 네비게이션 상태를 관리하는 StateNotifier
class NavigationNotifier extends StateNotifier<int> {
  NavigationNotifier() : super(0);
  void changePage(int newIndex) {
    state = newIndex;
  }
}

// 네비게이션 상태를 제공하는 Provider
final navigationProvider = StateNotifierProvider<NavigationNotifier, int>(
    (ref) => NavigationNotifier());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TaskHiveAdapter());
  // Box<TodoItem>를 열어두자.
  await Hive.openBox<Task>('tasks');
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationProvider);
    return MaterialApp(
      title: 'Modern Todo',
      home: Scaffold(
        body: Container(
          color: AppColors.selected,
          child: SafeArea(
            // IndexedStack을 사용해 페이지 전환
            child: IndexedStack(
              index: currentIndex,
              children: const [
                TodoView(),
                CalendarView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
