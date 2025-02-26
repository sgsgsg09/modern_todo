import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo/core/theme/app_theme.dart';
import 'package:modern_todo/core/theme/color_palette.dart';
import 'package:modern_todo/models/task.dart';
import 'package:modern_todo/models/task_category.dart';
import 'package:modern_todo/viewmodels/task_list/task_list_viewmodel.dart';

class TodoView extends ConsumerStatefulWidget {
  const TodoView({Key? key}) : super(key: key);

  @override
  ConsumerState<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends ConsumerState<TodoView> {
  // 현재 선택된 날짜 (기본 오늘 날짜)
  DateTime _currentDate = DateTime.now();
  // 선택된 TaskCategory (null이면 전체 작업)
  TaskCategory? _selectedCategory;

  // 예시용 TaskCategory 목록 (실제 앱에서는 DB나 Provider로 관리)
  final List<TaskCategory> _categories = [
    TaskCategory(id: 1, name: '일정', colorValue: AppColors.primary.value),
    TaskCategory(id: 2, name: '루틴', colorValue: AppColors.secondary.value),
    TaskCategory(id: 3, name: '이벤트', colorValue: AppColors.error.value),
    TaskCategory(
        id: 4, name: '개인 설정', colorValue: AppColors.secondaryVariant.value),
  ];

  @override
  Widget build(BuildContext context) {
    // TaskListFilter를 구성하여 TaskListViewModel에 전달
    final filter = TaskListFilter(
        selectedDate: _currentDate, selectedCategory: _selectedCategory);
    final tasksAsyncValue = ref.watch(taskListViewModelProvider(filter));

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: HeaderWidget(
          currentDate: _currentDate,
          onTodayPressed: () {
            setState(() {
              _currentDate = DateTime.now();
            });
          },
          onCalendarPressed: () {
            // 캘린더 페이지로 이동하는 로직 구현
          },
        ),
      ),
      body: Row(
        children: [
          // 왼쪽 사이드 탭: TaskCategory 목록
          SidebarWidget(
            categories: _categories,
            selectedCategory: _selectedCategory,
            onCategorySelected: (category) {
              setState(() {
                _selectedCategory = category;
              });
            },
          ),
          // 오른쪽 메인 콘텐츠 영역: 필터링된 작업 목록 표시
          Expanded(
            child: MainContentWidget(
              tasksAsyncValue: tasksAsyncValue,
              borderColor: _selectedCategory != null
                  ? Color(_selectedCategory!.colorValue)
                  : Colors.transparent,
            ),
          ),
        ],
      ),
      // 하단 오른쪽 플로팅 액션 버튼 (새 작업 추가)
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.accentColor,
        onPressed: () {
          // 새 작업 추가 액션 구현
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// 헤더 영역 위젯
class HeaderWidget extends StatelessWidget {
  final DateTime currentDate;
  final VoidCallback onTodayPressed;
  final VoidCallback onCalendarPressed;

  const HeaderWidget({
    Key? key,
    required this.currentDate,
    required this.onTodayPressed,
    required this.onCalendarPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 날짜 포맷: "July 4th 23.Mon"
    final formattedDate =
        "${_monthName(currentDate.month)} ${currentDate.day}th ${currentDate.year % 100}.${_dayOfWeek(currentDate.weekday)}";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: AppTheme.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(formattedDate, style: AppTheme.headerTitleStyle),
          Row(
            children: [
              TextButton(
                onPressed: onTodayPressed,
                child:
                    const Text("TODAY", style: TextStyle(color: Colors.white)),
              ),
              IconButton(
                onPressed: onCalendarPressed,
                icon: const Icon(Icons.calendar_today, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      "",
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return months[month];
  }

  String _dayOfWeek(int weekday) {
    const weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    return weekdays[(weekday - 1) % 7];
  }
}

/// 왼쪽 사이드 탭 위젯
class SidebarWidget extends StatelessWidget {
  final List<TaskCategory> categories;
  final TaskCategory? selectedCategory;
  final Function(TaskCategory?) onCategorySelected;

  const SidebarWidget({
    Key? key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      color: AppTheme.primaryColor.withOpacity(0.1),
      child: ListView(
        children: [
          // "전체" 탭: 선택되지 않은 경우 전체 작업 표시
          GestureDetector(
            onTap: () => onCategorySelected(null),
            child: Container(
              padding: const EdgeInsets.all(16),
              color: selectedCategory == null
                  ? AppTheme.accentColor
                  : Colors.transparent,
              child: Text(
                "전체",
                style: TextStyle(
                    color:
                        selectedCategory == null ? Colors.white : Colors.black),
              ),
            ),
          ),
          ...categories.map((category) => GestureDetector(
                onTap: () => onCategorySelected(category),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  color: selectedCategory?.id == category.id
                      ? Color(category.colorValue)
                      : Colors.grey[300],
                  child: Text(
                    category.name,
                    style: TextStyle(
                      color: selectedCategory?.id == category.id
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

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
            color: Color(task.category.colorValue),
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
