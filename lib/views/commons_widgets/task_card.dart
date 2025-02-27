import 'package:flutter/material.dart';
import 'package:modern_todo/core/theme/app_theme.dart';
import 'package:modern_todo/models/task.dart';

/// 체크리스트 카드 형태의 Task 카드 위젯
class TaskCard extends StatelessWidget {
  final Task task;
  const TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardColor =
        task.isCompleted ? Colors.grey[400] : AppTheme.todoCardBackground;
    return Card(
      color: cardColor,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(task.title, style: AppTheme.todoTitleStyle),
        subtitle:
            Text(_remainingTime(task), style: AppTheme.todoDescriptionStyle),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
        ),
        onTap: () {
          // 작업 체크/언체크 로직 구현 (예: 상태 업데이트)
        },
      ),
    );
  }

  String _remainingTime(Task task) {
    final now = DateTime.now();
    final difference = task.date.difference(now);
    if (difference.isNegative) {
      return "마감";
    } else {
      final hours = difference.inHours;
      final minutes = difference.inMinutes % 60;
      return "$hours시간 $minutes분 남음";
    }
  }
}
