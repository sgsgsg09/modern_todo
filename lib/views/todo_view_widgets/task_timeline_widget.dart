import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modern_todo/core/theme/app_theme.dart';
import 'package:modern_todo/core/theme/color_palette.dart';
import 'package:modern_todo/models/task.dart';
import 'package:modern_todo/models/task_category.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TaskTimelineWidget extends StatelessWidget {
  final DateTime currentDate;
  final TaskCategory? selectedCategory;
  final List<Task> tasks;
  final List<TaskCategory> categories;
  // 범주 변경 UI는 제거되었으므로 onCategoryChanged도 제거하거나, 다른 용도로 사용할 수 있습니다.
  // final ValueChanged<TaskCategory?> onCategoryChanged;

  const TaskTimelineWidget({
    Key? key,
    required this.currentDate,
    required this.selectedCategory,
    required this.tasks,
    required this.categories,
    // required this.onCategoryChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? Center(
            child: Text(
              '해당 조건의 Task가 없습니다.',
              style: AppTheme.todoDescriptionStyle,
            ),
          )
        : ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];

              final bool isHighlighted =
                  task.title.toLowerCase().contains('meeting');

              // 예상 소요시간(durationInMinutes)을 기반으로 선의 굵기를 동적으로 조절
              double thickness = 3;

              return TimelineTile(
                alignment: TimelineAlign.manual,
                lineXY: 0.00,
                isFirst: index == 0,
                isLast: index == tasks.length - 1,
                // indicator: 일정 시점을 나타내는 원형
                indicatorStyle: IndicatorStyle(
                  width: 14,
                  indicatorXY: 0.5, // 원형이 수직으로 중앙에 위치
                  color: isHighlighted ? AppColors.primary : AppColors.primary,
                ),
                // beforeLineStyle: indicator 전후로 이어지는 선 스타일
                beforeLineStyle: LineStyle(
                  color: AppColors.primary,
                  thickness: thickness,
                ),
                afterLineStyle: LineStyle(
                  color: AppColors.primary,
                  thickness: thickness,
                ),
                // startChild: 타임라인 왼쪽 영역 아래쪽에 배치할 콘텐츠 (여기선 빈 영역 처리)
                startChild: const SizedBox.shrink(),

                // Task의 주요 정보를 오른쪽에 표시
                endChild: Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8), // 일정 간격을 위해 세로 여백
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: isHighlighted ? Colors.blue : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 일정 제목
                              Text(
                                task.title,
                                style: isHighlighted
                                    ? AppTheme.highlightTitleStyle // 강조 일정의 스타일
                                    : AppTheme.todoTitleStyle,
                              ),
                              const SizedBox(height: 8),
                              // 일정 부가 설명 (notes)
                              if (task.notes != null && task.notes!.isNotEmpty)
                                Text(
                                  task.notes!,
                                  style: isHighlighted
                                      ? AppTheme.highlightDescriptionStyle
                                      : AppTheme.todoDescriptionStyle,
                                ),
                              const SizedBox(height: 8),
                            ],
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Text(
                              task.startTime != null
                                  ? task.startTime!.format(context)
                                  : '',
                              style: isHighlighted
                                  ? AppTheme.highlightDescriptionStyle
                                  : AppTheme.timeTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }
}
