import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo/models/todo_item.dart';
import 'package:modern_todo/viewmodels/todo_viewmodel.dart';
import 'package:modern_todo/views/todo_widgets/header_section.dart';
import 'package:modern_todo/views/todo_widgets/date_tabs.dart';
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
    // Today, Tomorrow, All 탭 3개 구성
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncTodos = ref.watch(todoViewModelProvider);

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              const HeaderSection(),
              DateTabs(tabController: _tabController),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildTodoList(asyncTodos, filter: 'today'),
                    _buildTodoList(asyncTodos, filter: 'tomorrow'),
                    _buildTodoList(asyncTodos, filter: 'all'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 필터에 따라 TodoItem 목록을 반환 (startDate를 기준)
  Widget _buildTodoList(AsyncValue<List<TodoItem>> asyncTodos,
      {required String filter}) {
    return asyncTodos.when(
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
        // 'all'인 경우 전체 목록 사용

        // 목록이 비어 있으면 안내 문구와 "Add New Todo" 점선 카드 표시
        if (filtered.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                AddTodoDottedCard(onTap: _openAddTodoDialog),
              ],
            ),
          );
        }

        return Container(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: filtered.length + 1, // 마지막 항목은 점선 카드
            itemBuilder: (context, index) {
              if (index < filtered.length) {
                final todo = filtered[index];
                return TodoCard(todo: todo);
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: AddTodoDottedCard(onTap: _openAddTodoDialog),
                );
              }
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
          child:
              Text("오류 발생: $error", style: const TextStyle(color: Colors.red))),
    );
  }

  Future<void> _openAddTodoDialog() async {
    final newTodo = await showDialog<TodoItem>(
      context: context,
      builder: (context) => const AddTodoDialog(),
    );
    if (newTodo != null) {
      // 다이얼로그에서 입력한 날짜를 startDate와 endDate에 할당
      final todoWithDates = newTodo.copyWith(
        startDate: newTodo.startDate,
        endDate: newTodo.startDate,
      );
      await ref.read(todoViewModelProvider.notifier).addTodo(todoWithDates);
    }
  }
}
