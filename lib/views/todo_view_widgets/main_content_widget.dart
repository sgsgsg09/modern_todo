import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo/core/theme/app_theme.dart';
import 'package:modern_todo/models/task.dart';
import 'package:modern_todo/viewmodels/viewmodels_models/task_list_filter.dart';
import 'package:modern_todo/views/commons_widgets/task_card.dart';
import 'package:modern_todo/viewmodels/task_list/task_list_viewmodel.dart';

/// 오른쪽 메인 콘텐츠 영역 위젯
class MainContentWidget extends ConsumerStatefulWidget {
  final TaskListFilter filter;
  final AsyncValue<List<Task>> tasksAsyncValue;

  const MainContentWidget({
    Key? key,
    required this.filter,
    required this.tasksAsyncValue,
  }) : super(key: key);

  @override
  ConsumerState<MainContentWidget> createState() => _MainContentWidgetState();
}

class _MainContentWidgetState extends ConsumerState<MainContentWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.tasksAsyncValue.when(
        data: (tasks) => tasks.isEmpty
            ? Center(
                child: Text(
                  "작업이 없습니다.",
                  style: AppTheme.addTodoTextStyle,
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return TaskCard(
                    task: task,
                    onCheck: (value) {
                      ref
                          .read(
                              taskListViewModelProvider(widget.filter).notifier)
                          .toggleTaskCompletion(task);
                    },
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, st) => Center(
          child: Text(
            "오류 발생: $error",
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
