import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:modern_todo/adapters/task_hive_adapter.dart';
import 'package:modern_todo/core/theme/color_palette.dart';
import 'package:modern_todo/models/task.dart';
import 'package:modern_todo/resource/message/generated/l10n.dart';
import 'package:modern_todo/views/calendar_view.dart';

import 'package:modern_todo/views/todo_view.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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

// 전역 Locale 상태를 위한 Provider (초기값은 영어)
final localeProvider = StateProvider<Locale>((ref) => const Locale('en'));

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TaskHiveAdapter());
  // Box<TodoItem>를 열어두자.
  await Hive.openBox<Task>('tasks');
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) {
    return context.findAncestorStateOfType<_MyAppState>();
  }
}

class _MyAppState extends ConsumerState<MyApp> {
  // Method to change the locale
  void changeLocale(Locale newLocale) {
    ref.read(localeProvider.notifier).state = newLocale;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(navigationProvider);
    final locale = ref.watch(localeProvider);
    return MaterialApp(
      title: 'Simple Todo',
      locale: locale, // 전역 Locale 상태 (예: Provider, State 관리)
      localizationsDelegates: const [
        S.delegate, // intl 도구로 생성된 delegate
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        // S.delegate, 또는 직접 만든 delegate 추가 가능
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: Builder(builder: (context) {
        return Scaffold(
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
        );
      }),
    );
  }
}
