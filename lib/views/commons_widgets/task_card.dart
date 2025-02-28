import 'package:flutter/material.dart';
import 'package:modern_todo/core/theme/app_theme.dart';
import 'package:modern_todo/core/theme/color_palette.dart';
import 'package:modern_todo/models/task.dart';

/// 체크리스트 카드 형태의 Task 카드 위젯
class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap; // 카드 전체 탭 시 실행할 콜백
  final ValueChanged<bool?>? onCheck; // 체크박스 상태 변경 시 실행할 콜백

  const TaskCard({
    Key? key,
    required this.task,
    this.onTap,
    this.onCheck,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // 체크박스 영역 (InkWell에 포함되지 않음)
          Checkbox(
            value: task.isCompleted,
            onChanged: onCheck,
            activeColor: AppTheme.primaryColor,
          ),
          // 카드의 나머지 영역 (InkWell 적용)
          Expanded(
            child: InkWell(
              onTap: onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 첫 번째 줄: 작업 제목과 남은 시간 표시
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          task.title,
                          style: AppTheme.todoTitleStyle.copyWith(
                            color: AppTheme.primaryColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.access_time,
                              size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            _remainingTime(task),
                            style: AppTheme.todoDescriptionStyle.copyWith(
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _remainingTime(Task task) {
    final now = DateTime.now();
    final difference = task.date.difference(now);
    if (difference.isNegative) return "마감";
    final totalMinutes = difference.inMinutes;
    if (totalMinutes < 60) return "$totalMinutes분 남음";
    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;
    return "$hours시간 $minutes분 남음";
  }
}
