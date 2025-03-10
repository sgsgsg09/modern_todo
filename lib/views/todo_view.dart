import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// 테마 관련
import 'package:modern_todo/core/theme/app_theme.dart';
import 'package:modern_todo/core/theme/color_palette.dart';
import 'package:modern_todo/main.dart';

// 모델
import 'package:modern_todo/models/task_category.dart';
import 'package:modern_todo/resource/message/generated/l10n.dart';
import 'package:modern_todo/viewmodels/calendars/calendar_viewmodel.dart';
import 'package:modern_todo/viewmodels/task_detail/categories_viewmodel.dart';

// 뷰모델
import 'package:modern_todo/viewmodels/task_list/task_list_viewmodel.dart';
import 'package:modern_todo/viewmodels/viewmodels_models/task_list_filter.dart';
import 'package:modern_todo/views/commons_widgets/show_addtask_bottomsheet.dart';

// 위젯들
import 'package:modern_todo/views/todo_view_widgets/header_widget.dart';
import 'package:modern_todo/views/todo_view_widgets/sidebar_widget.dart';
import 'package:modern_todo/views/todo_view_widgets/task_timeline_widget.dart';

/// TodoView: 전체 Todo 화면을 구성하는 StatefulWidget
class TodoView extends ConsumerStatefulWidget {
  const TodoView({Key? key}) : super(key: key);

  @override
  ConsumerState<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends ConsumerState<TodoView> {
  // 현재 선택된 날짜
  final DateTime _currentDate = DateTime.now();
  // 현재 선택된 카테고리 (null이면 전체)
  TaskCategory? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    //필터 객체 생성.
    final filter = TaskListFilter(
      selectedDate: _currentDate,
      selectedCategoryId: _selectedCategory?.id,
    );
// 필터를 사용하여 TaskListViewModel (family provider) 구독
    final taskListAsync = ref.watch(taskListViewModelProvider(filter));
    // 카테고리 목록을 비동기로 받아옴
    final categoriesAsync = ref.watch(categoriesViewmodelProvider);

    return Scaffold(
      body: Row(
        children: [
          /// 사이드바 영역: 카테고리 목록을 SidebarWidget에 전달
          Expanded(
            flex: 1,
            child: categoriesAsync.when(
              data: (categories) => SidebarWidget(
                categories: categories,
                selectedCategory: _selectedCategory,
                onCategorySelected: (category) {
                  setState(
                    () {
                      _selectedCategory = category;
                    },
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) =>
                  Center(child: Text(S.of(context).generalError)),
            ),
          ),

          /// 메인 콘텐츠 영역
          Expanded(
            flex: 10,
            child: Container(
              color: AppColors.background,
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  /// 헤더 영역
                  HeaderWidget(
                    currentDate: _currentDate,
                    onCalendarPressed: () {
                      // 버튼 클릭 시 네비게이션 상태를 변경해 CalendarView로 전환
                      ref.read(navigationProvider.notifier).changePage(1);
                    },
                  ),
                  Expanded(
                    child: taskListAsync.when(
                      data: (tasks) => categoriesAsync.when(
                        data: (categories) => TaskTimelineWidget(
                          currentDate: _currentDate,
                          selectedCategory: _selectedCategory,
                          tasks: tasks,
                          categories: categories,
                          onTaskTap: (task) async {
                            // 기존 Task를 수정/삭제하는 바텀시트 표시
                            final result = await showAddTaskBottomSheet(
                              context: context,
                              categories: categories,
                              filter: filter, // ★ filter 전달
                              existingTask: task,
                            );
                          },
                        ),
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (error, stack) => Center(
                            child: Text(S.of(context).categoryLoadError)),
                      ),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (error, stack) =>
                          Center(child: Text(S.of(context).taskLoadError)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // 우측 하단 FloatingActionButton
      floatingActionButton: categoriesAsync.when(
        data: (categories) => FloatingActionButton(
          backgroundColor: AppTheme.accentColor,
          onPressed: () async {
            // 신규 Task를 추가하는 바텀시트
            final result = await showAddTaskBottomSheet(
              context: context,
              categories: categories,
              filter: filter, // ★ 동일하게 filter 전달
            );
          },
          child: const Icon(Icons.add),
        ),
        loading: () => const SizedBox.shrink(),
        error: (error, stack) => const SizedBox.shrink(),
      ),
    );
  }
}
