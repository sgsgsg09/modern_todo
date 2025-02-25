import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo/models/task.dart';
import 'package:modern_todo/viewmodels/calendars/calendar_viewmodel.dart';
import 'package:modern_todo/views/calendar_view.dart';
import 'package:modern_todo/views/todo_widgets/header_section.dart';
import 'package:modern_todo/todo_cards/todo_card.dart';
import 'package:modern_todo/views/todo_widgets/add_todo_dotted_card.dart';
import 'package:modern_todo/views/todo_widgets/add_todo_BottomSheet.dart';

class TodoView extends ConsumerStatefulWidget {
  const TodoView({Key? key}) : super(key: key);

  @override
  ConsumerState<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends ConsumerState<TodoView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Today, Tomorrow, Calendar 탭 3개 구성
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// 탭에 따른 Todo 목록과 HeaderSection을 함께 보여주는 위젯
  Widget _buildTodoTab(String filter) {
    final todosAsyncValue = ref.watch(calendarViewModelProvider);
    return Column(
      children: [
        Expanded(
          child: _TodoList(
            filter: filter,
            todosAsyncValue: todosAsyncValue,
            onAddTodo: _AddTodoBottomSheet,
          ),
        ),
      ],
    );
  }

  Widget _todayBuildTodoTab(String filter) {
    final todosAsyncValue = ref.watch(calendarViewModelProvider);
    return Column(
      children: [
        const HeaderSection(),
        Expanded(
          child: _TodoList(
            filter: filter,
            todosAsyncValue: todosAsyncValue,
            onAddTodo: _AddTodoBottomSheet,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            // 왼쪽 영역: 사용자 정의 색상에 따라 스타일링한 커스텀 탭바
            Container(
              width: 120,
              padding: const EdgeInsets.all(8),
              child: CustomTabBar(
                currentIndex: _tabController.index,
                onTabSelected: (index) {
                  _tabController.animateTo(index);
                  setState(() {});
                },
              ),
            ),
            // 오른쪽 영역: 각 탭의 내용
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _todayBuildTodoTab('today'),
                  _buildTodoTab('tomorrow'),
                  const CalendarView(key: ValueKey('calendar')),
                ],
              ),
            ),
          ],
        ),
      ),
      // Calendar 탭일 때만 FloatingActionButton 노출
      floatingActionButton: AnimatedSwitcher(
        duration: const Duration(milliseconds: 100),
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        child: _tabController.index == 2
            ? FloatingActionButton(
                key: const ValueKey('fab'),
                onPressed: () {
                  // Calendar 탭에 맞는 동작 구현 (예: 일정 추가)
                },
                backgroundColor: Colors.pinkAccent,
                child: const Icon(Icons.add),
              )
            : const SizedBox(key: ValueKey('empty')),
      ),
    );
  }

  /// 새 Todo 항목을 추가하는 바텀 시트 오픈
  Future<void> _AddTodoBottomSheet() async {
    final newTodo = await showModalBottomSheet<TodoItem>(
      context: context,
      isScrollControlled: true,
      builder: (context) => const AddTodoBottomSheet(),
    );
    if (newTodo != null) {
      final todoWithDates = newTodo.copyWith(
        startDate: newTodo.startDate,
        endDate: newTodo.isAllDay ? newTodo.startDate : newTodo.endDate,
      );
      await ref.read(calendarViewModelProvider.notifier).addTodo(todoWithDates);
    }
  }
}

/// CustomTabBar: 사용자 정의 색상에 따라 각 탭을 동적으로 꾸밀 수 있는 커스텀 탭바 위젯
class CustomTabBar extends ConsumerWidget {
  final int currentIndex;
  final Function(int) onTabSelected;

  const CustomTabBar({
    Key? key,
    required this.currentIndex,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 아래 색상들은 예시이며, 실제로는 viewmodel이나 별도 Provider를 통해 사용자가 정의한 색상을 받아오면 됩니다.
    Color todayActiveColor = Colors.blue;
    Color tomorrowActiveColor = Colors.green;
    Color calendarActiveColor = Colors.orange;

    // 각 탭에 대한 정보
    final tabs = [
      {'title': 'Today', 'activeColor': todayActiveColor},
      {'title': 'Tomorrow', 'activeColor': tomorrowActiveColor},
      {'title': 'Calendar', 'activeColor': calendarActiveColor},
    ];

    return Column(
      children: List.generate(tabs.length, (index) {
        final tab = tabs[index];
        final bool isSelected = index == currentIndex;
        return GestureDetector(
          onTap: () => onTabSelected(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            decoration: BoxDecoration(
              color:
                  isSelected ? tab['activeColor'] as Color : Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                tab['title'] as String,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

/// Todo 목록을 필터링하여 보여주는 위젯
class _TodoList extends StatelessWidget {
  final String filter;
  final AsyncValue<List<TodoItem>> todosAsyncValue;
  final VoidCallback onAddTodo;

  const _TodoList({
    Key? key,
    required this.filter,
    required this.todosAsyncValue,
    required this.onAddTodo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return todosAsyncValue.when(
      data: (todos) {
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);
        final tomorrow = DateTime(now.year, now.month, now.day + 1);

        bool isWithinRange(DateTime day, TodoItem item) {
          final d = DateTime(day.year, day.month, day.day);
          final start = DateTime(
              item.startDate.year, item.startDate.month, item.startDate.day);
          final end =
              DateTime(item.endDate.year, item.endDate.month, item.endDate.day);
          return !d.isBefore(start) && !d.isAfter(end);
        }

        List<TodoItem> filtered = todos;
        if (filter == 'today') {
          filtered = todos.where((t) => isWithinRange(today, t)).toList();
        } else if (filter == 'tomorrow') {
          filtered = todos.where((t) => isWithinRange(tomorrow, t)).toList();
        }

        if (filtered.isEmpty) {
          return Center(child: AddTodoDottedCard(onTap: onAddTodo));
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemCount: filtered.length + 1,
          itemBuilder: (context, index) {
            if (index < filtered.length) {
              final todo = filtered[index];
              return TodoCard(todo: todo);
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: AddTodoDottedCard(onTap: onAddTodo),
              );
            }
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text(
          "오류 발생: $error",
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
