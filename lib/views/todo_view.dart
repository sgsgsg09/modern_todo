import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 테마 관련
import 'package:modern_todo/core/theme/app_theme.dart';
import 'package:modern_todo/core/theme/color_palette.dart';

// 모델
import 'package:modern_todo/models/task_category.dart';

// 뷰모델
import 'package:modern_todo/viewmodels/task_list/task_list_viewmodel.dart';
import 'package:modern_todo/views/todo_view_widgets/header_widget.dart';
import 'package:modern_todo/views/todo_view_widgets/main_content_widget.dart';
import 'package:modern_todo/views/todo_view_widgets/sidebar_widget.dart';

// 위젯

/// TodoView: 전체 Todo 화면을 구성하는 StatefulWidget
class TodoView extends ConsumerStatefulWidget {
  const TodoView({Key? key}) : super(key: key);

  @override
  ConsumerState<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends ConsumerState<TodoView> {
  // 현재 선택된 날짜
  DateTime _currentDate = DateTime.now();

  // 선택된 카테고리 (null이면 전체)
  TaskCategory? _selectedCategory;

  // 예시용 카테고리 목록 (실제 앱에서는 DB나 Provider를 통해 관리할 수 있음)
  final List<TaskCategory> _categories = [
    TaskCategory(id: 1, name: '일정', colorValue: AppColors.primary.value),
    TaskCategory(id: 2, name: '루틴', colorValue: AppColors.secondary.value),
  ];

  @override
  Widget build(BuildContext context) {
    // TaskListFilter를 구성하여 TaskListViewModel에 전달
    final filter = TaskListFilter(
      selectedDate: _currentDate,
      selectedCategory: _selectedCategory,
    );

    // TaskListViewModel로부터 필터링된 Task 목록을 가져옴 (AsyncValue)
    final tasksAsyncValue = ref.watch(taskListViewModelProvider(filter));

    return Scaffold(
      body: Row(
        children: [
          /// 사이드바 영역
          Expanded(
            flex: 1,
            child: SidebarWidget(
              categories: _categories,
              selectedCategory: _selectedCategory,
              onCategorySelected: (category) {
                setState(() {
                  _selectedCategory = category;
                });
              },
            ),
          ),

          /// 메인 콘텐츠 영역
          Expanded(
            flex: 10,
            child: Container(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  /// 헤더 영역
                  HeaderWidget(
                    currentDate: _currentDate,
                    onTodayPressed: () {
                      setState(() {
                        _currentDate = DateTime.now();
                      });
                    },
                    onCalendarPressed: () {
                      // 캘린더 페이지로 이동하는 로직
                    },
                  ),

                  /// 실제 할 일 목록을 보여주는 메인 위젯
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
            ),
          ),
        ],
      ),
      // 우측 하단 FloatingActionButton
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.accentColor,
        onPressed: () {
          // 새 작업 추가 로직
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
