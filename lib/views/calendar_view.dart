import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo/core/theme/app_theme.dart';
import 'package:modern_todo/core/theme/color_palette.dart';
import 'package:modern_todo/main.dart';
import 'package:modern_todo/viewmodels/task_detail/categories_viewmodel.dart';
import 'package:modern_todo/views/commons_widgets/show_addtask_bottomsheet.dart';
import 'package:modern_todo/views/commons_widgets/task_card.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:modern_todo/models/task.dart';
import 'package:modern_todo/viewmodels/calendars/calendar_viewmodel.dart';

class CalendarView extends ConsumerStatefulWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  ConsumerState<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends ConsumerState<CalendarView> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final calendarAsync = ref.watch(calendarViewModelProvider);
    final someCategoryList = ref.watch(categoriesViewmodelProvider);
    return Scaffold(
      backgroundColor: AppTheme.primaryColor, // 테마 색상 사용
      body: SafeArea(
        child: Column(
          children: [
            // 달력 부분 위젯 분리
            calendarAsync.when(
              data: (tasks) => CalendarTableWidget(
                tasks: tasks,
                focusedDay: _focusedDay,
                selectedDay: _selectedDay,
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                onTodoPressed: () {
                  // 버튼 클릭 시 네비게이션 상태를 변경해 CalendarView로 전환
                  ref.read(navigationProvider.notifier).changePage(0);
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, st) => Center(
                child: Text(
                  "오류 발생: $error",
                  style: TextStyle(color: AppTheme.errorColor),
                ),
              ),
            ),
            // Upcoming 섹션 위젯 분리
            Expanded(
              child: calendarAsync.when(
                data: (tasks) => someCategoryList.when(
                  data: (categories) => UpcomingTasksSection(
                    // tasksFuture는 AsyncValue<List<Task>> 타입이므로
                    // 이미 로드된 tasks를 AsyncValue.data(...)로 감싸서 넘긴다.
                    tasksFuture: AsyncValue.data(tasks),
                    selectedDay: _selectedDay,
                    onTaskTap: (task) async {
                      final updatedTask = await showAddTaskBottomSheet(
                        context: context,
                        categories: categories, // 로드된 실제 카테고리 목록
                        existingTask: task,
                      );
                      if (updatedTask != null) {
                        ref
                            .read(calendarViewModelProvider.notifier)
                            .updateTask(updatedTask);
                      }
                      if (updatedTask == 'delete') {
                        ref
                            .read(calendarViewModelProvider.notifier)
                            .deleteTask(task);
                      }
                    },
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) =>
                      Center(child: Text('카테고리 로드 에러: $error')),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) =>
                    Center(child: Text('Task 로드 에러: $error')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalendarTableWidget extends StatelessWidget {
  final List<Task> tasks;
  final DateTime focusedDay;
  final DateTime selectedDay;
  final Function(DateTime, DateTime) onDaySelected;
  final VoidCallback onTodoPressed;

  const CalendarTableWidget({
    Key? key,
    required this.tasks,
    required this.focusedDay,
    required this.selectedDay,
    required this.onDaySelected,
    required this.onTodoPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.primaryColor, // 테마에서 가져온 색상 사용
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: onTodoPressed,
              icon: const Icon(
                Icons.home,
                color: AppColors.textPrimary,
                size: 30,
              ),
            ),
          ),
          TableCalendar<Task>(
            firstDay: DateTime(2000),
            lastDay: DateTime(2100),
            focusedDay: focusedDay,
            selectedDayPredicate: (day) => isSameDay(selectedDay, day),
            onDaySelected: onDaySelected,
            // Task 목록을 필터링하는 유틸리티 메서드 사용
            eventLoader: (day) => CalendarViewModel.getEventsForDay(day, tasks),
            calendarStyle: CalendarStyle(
              defaultTextStyle: const TextStyle(color: Colors.white),
              weekendTextStyle: const TextStyle(color: Colors.white70),
              todayDecoration: BoxDecoration(
                color: AppColors.secondary, // AppColors로 보조 색상 사용
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: AppTheme.accentColor,
                shape: BoxShape.circle,
              ),
              outsideTextStyle: TextStyle(color: AppTheme.greyColor),
              markersAutoAligned: false,
              markerDecoration: BoxDecoration(
                color: AppColors.secondaryVariant,
                shape: BoxShape.circle,
              ),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(color: AppTheme.greyColor),
              weekendStyle: TextStyle(color: AppTheme.greyColor),
            ),
            headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              titleTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
              rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
            ),

            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, day, events) {
                if (events.isNotEmpty) {
                  return Positioned(
                    bottom: 4,
                    child: MarkerWidget(events: events.cast<Task>()),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class UpcomingTasksSection extends StatelessWidget {
  final AsyncValue<List<Task>> tasksFuture;
  final DateTime selectedDay;
// 변경 전
// final VoidCallback? onTaskTap;

// 변경 후
  final ValueChanged<Task>?
      onTaskTap; // 범주 변경 UI는 제거되었으므로 onCategoryChanged도 제거하거나, 다른 용도로 사용할 수 있습니다.
  const UpcomingTasksSection({
    Key? key,
    required this.tasksFuture,
    required this.selectedDay,
    this.onTaskTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background, // 테마 색상 사용
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: tasksFuture.when(
        data: (tasks) {
          final events = CalendarViewModel.getEventsForDay(selectedDay, tasks);
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: events.isEmpty
                ? Center(
                    child: Text(
                      "해당 날짜에 일정이 없습니다.",
                      style: TextStyle(color: AppColors.background),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Upcoming",
                        style: AppTheme.headerTitleStyle,
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: ListView.builder(
                          itemCount: events.length,
                          itemBuilder: (context, index) {
                            final task = events[index];
                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder: (child, animation) =>
                                  FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                              child: GestureDetector(
                                onTap: () => onTaskTap?.call(task), // <-- 추가
                                child: TaskCard(
                                  key: ValueKey(task.id),
                                  task: task,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, st) => Center(
            child: Text("오류 발생: $error",
                style: TextStyle(color: AppTheme.errorColor))),
      ),
    );
  }
}

class MarkerWidget extends StatelessWidget {
  final List<Task> events;

  const MarkerWidget({Key? key, required this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (events.length <= 3) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: events
            .map((event) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 1.5),
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        Color((event.colorValue ?? AppColors.primary) as int),
                  ),
                ))
            .toList(),
      );
    } else {
      final dots = events.take(3).map((event) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 1.5),
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color((event.colorValue ?? AppColors.primary) as int),
            ),
          ));
      final moreCount = events.length - 3;
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...dots,
          Container(
            margin: const EdgeInsets.only(left: 2),
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.greyColor,
            ),
            child: Text(
              '+$moreCount',
              style: const TextStyle(
                fontSize: 8,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    }
  }
}
