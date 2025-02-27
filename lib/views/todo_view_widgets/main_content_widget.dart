import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo/core/theme/app_theme.dart';
import 'package:modern_todo/models/task.dart';
import 'package:modern_todo/views/todo_view.dart';
import 'package:modern_todo/views/commons_widgets/task_card.dart';

/// 오른쪽 메인 콘텐츠 영역 위젯
class MainContentWidget extends StatelessWidget {
  final AsyncValue<List<Task>> tasksAsyncValue;
  final Color borderColor;

  const MainContentWidget({
    Key? key,
    required this.tasksAsyncValue,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(left: BorderSide(width: 10, color: borderColor)),
      ),
      child: tasksAsyncValue.when(
        data: (tasks) => tasks.isEmpty
            ? Center(child: Text("작업이 없습니다.", style: AppTheme.addTodoTextStyle))
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return TaskCard(task: task);
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, st) => Center(
            child: Text("오류 발생: $error",
                style: const TextStyle(color: Colors.red))),
      ),
    );
  }
}
