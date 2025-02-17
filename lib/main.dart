import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo/core/constants/flip_view.dart';
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
    // FlipViewState에 접근하기 위한 GlobalKey
    final GlobalKey<FlipViewState> flipKey = GlobalKey<FlipViewState>();

    return MaterialApp(
      title: 'Modern Todo',
      home: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Modern Todo'),
        //   actions: [
        //     IconButton(
        //       icon: const Icon(Icons.flip),
        //       onPressed: () {
        //         // 플립 버튼을 누르면 FlipView의 flip() 메서드를 호출
        //         flipKey.currentState?.flip();
        //       },
        //     ),
        //   ],
        // ),
        body: FlipView(
          key: flipKey,
          front: const TodoView(),
          back: const CalendarView(),
        ),
      ),
    );
  }
}
