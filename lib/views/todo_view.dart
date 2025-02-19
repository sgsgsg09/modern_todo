import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo/models/todo_item.dart';
import 'package:modern_todo/viewmodels/calendar_viewmodel.dart';
import 'package:modern_todo/views/calendar_view.dart';
import 'package:modern_todo/views/todo_widgets/header_section.dart';
import 'package:modern_todo/widgets/todo_card.dart';
import 'package:modern_todo/widgets/add_todo_dotted_card.dart';
import 'package:modern_todo/widgets/add_todo_dialog.dart';

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
      // 탭 변경 시 UI 갱신 (FAB 등 조건부 UI)
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
    // viewmodel의 상태(AsyncValue<List<TodoItem>>)를 구독합니다.
    final todosAsyncValue = ref.watch(calendarViewModelProvider);
    return Column(
      children: [
        Expanded(
          child: _TodoList(
            filter: filter,
            todosAsyncValue: todosAsyncValue,
            onAddTodo: _openAddTodoDialog,
          ),
        ),
      ],
    );
  }

  Widget _todayBuildTodoTab(String filter) {
    // viewmodel의 상태(AsyncValue<List<TodoItem>>)를 구독합니다.
    final todosAsyncValue = ref.watch(calendarViewModelProvider);
    return Column(
      children: [
        const HeaderSection(),
        Expanded(
          child: _TodoList(
            filter: filter,
            todosAsyncValue: todosAsyncValue,
            onAddTodo: _openAddTodoDialog,
          ),
        ),
      ],
    );
  }

  /// 상단 탭바를 구성하는 위젯
  Widget _buildTabBar() {
    return Container(
      child: TabBar(
        controller: _tabController,
        indicatorColor: Colors.pinkAccent,
        labelColor: const Color.fromARGB(255, 0, 0, 0),
        unselectedLabelColor: Colors.grey,
        tabs: const [
          Tab(text: 'Today'),
          Tab(text: 'Tomorrow'),
          Tab(icon: Icon(Icons.calendar_month)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // SafeArea를 통해 기기별 안전 영역 확보
      body: SafeArea(
        child: Column(
          children: [
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Today 탭
                  _todayBuildTodoTab('today'),
                  // Tomorrow 탭
                  _buildTodoTab('tomorrow'),
                  // Calendar 탭
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

  /// 새 Todo 항목을 추가하는 다이얼로그 오픈
  Future<void> _openAddTodoDialog() async {
    final newTodo = await showDialog<TodoItem>(
      context: context,
      builder: (context) => const AddTodoDialog(),
    );
    if (newTodo != null) {
      // 필요에 따라 시작/종료 날짜를 조정
      final todoWithDates = newTodo.copyWith(
        startDate: newTodo.startDate,
        endDate: newTodo.startDate,
      );
      await ref.read(calendarViewModelProvider.notifier).addTodo(todoWithDates);
    }
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
        List<TodoItem> filtered = todos;

        if (filter == 'today') {
          filtered = todos
              .where((t) =>
                  t.startDate.year == now.year &&
                  t.startDate.month == now.month &&
                  t.startDate.day == now.day)
              .toList();
        } else if (filter == 'tomorrow') {
          final tomorrow = DateTime(now.year, now.month, now.day + 1);
          filtered = todos
              .where((t) =>
                  t.startDate.year == tomorrow.year &&
                  t.startDate.month == tomorrow.month &&
                  t.startDate.day == tomorrow.day)
              .toList();
        }

        // 항목이 없으면 추가 버튼 카드만 보여줌
        if (filtered.isEmpty) {
          return Center(
            child: AddTodoDottedCard(onTap: onAddTodo),
          );
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
