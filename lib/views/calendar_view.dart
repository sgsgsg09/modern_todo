import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo/widgets/todo_card.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:modern_todo/models/todo_item.dart';
import 'package:modern_todo/viewmodels/calendar_viewmodel.dart';

class CalendarView extends ConsumerStatefulWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  ConsumerState<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends ConsumerState<CalendarView> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  /// 해당 날짜가 일정(startDate~endDate) 범위 안에 들어가는지 체크
  bool _isWithinRange(DateTime day, TodoItem item) {
    final d = DateTime(day.year, day.month, day.day);
    final start =
        DateTime(item.startDate.year, item.startDate.month, item.startDate.day);
    final end =
        DateTime(item.endDate.year, item.endDate.month, item.endDate.day);
    return d.isAfter(start.subtract(const Duration(days: 1))) &&
        d.isBefore(end.add(const Duration(days: 1)));
  }

  /// 지정된 day에 해당하는 TodoItem들을 필터링
  List<TodoItem> _getEventsForDay(DateTime day, List<TodoItem> allTodos) {
    return allTodos.where((item) => _isWithinRange(day, item)).toList();
  }

  /// 마커 표시 위젯 (이벤트가 여러 개면 점 여러 개 표시)
  Widget _buildMarker(List<TodoItem> events) {
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
                    color: Color(event.color),
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
              color: Color(event.color),
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
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
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

  @override
  Widget build(BuildContext context) {
    final calendarAsync = ref.watch(calendarViewModelProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Column(
          children: [
            // 상단: 어두운색 배경 안에 달력
            calendarAsync.when(
              data: (todos) => Container(
                color: const Color(0xFF121212),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TableCalendar<TodoItem>(
                  firstDay: DateTime(2000),
                  lastDay: DateTime(2100),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  eventLoader: (day) => _getEventsForDay(day, todos),
                  calendarStyle: CalendarStyle(
                    defaultTextStyle: const TextStyle(color: Colors.white),
                    weekendTextStyle: const TextStyle(color: Colors.white70),
                    todayDecoration: BoxDecoration(
                      color: Colors.grey[700],
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: const BoxDecoration(
                      color: Colors.pinkAccent,
                      shape: BoxShape.circle,
                    ),
                    outsideTextStyle: TextStyle(color: Colors.grey[700]),
                    markersAutoAligned: false,
                    markerDecoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(color: Colors.grey[400]),
                    weekendStyle: TextStyle(color: Colors.grey[400]),
                  ),
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    titleTextStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    leftChevronIcon:
                        const Icon(Icons.chevron_left, color: Colors.white),
                    rightChevronIcon:
                        const Icon(Icons.chevron_right, color: Colors.white),
                  ),
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, day, events) {
                      if (events.isNotEmpty) {
                        return Positioned(
                          bottom: 4,
                          child: _buildMarker(events.cast<TodoItem>()),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, st) => Center(child: Text("오류 발생: $error")),
            ),

            // 하단: Upcoming 섹션 (흰색 배경 + 둥근 모서리)
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: calendarAsync.when(
                  data: (todos) {
                    final events = _getEventsForDay(_selectedDay, todos);
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: events.isEmpty
                          ? const Center(child: Text("해당 날짜에 일정이 없습니다."))
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Upcoming",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: events.length,
                                    itemBuilder: (context, index) {
                                      final todo = events[index];
                                      return AnimatedSwitcher(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        transitionBuilder: (child, animation) =>
                                            FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        ),
                                        // 각 TodoCard에 고유의 키를 부여하여 AnimatedSwitcher가 변화를 감지할 수 있도록 합니다.
                                        child: TodoCard(
                                          key: ValueKey(todo.id),
                                          todo: todo,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, st) => Center(child: Text("오류 발생: $error")),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 일정 추가 다이얼로그 (startDate/endDate를 직접 입력받으려면 위젯을 확장 가능)
class AddTodoDialogCalendar extends StatefulWidget {
  const AddTodoDialogCalendar({Key? key}) : super(key: key);

  @override
  State<AddTodoDialogCalendar> createState() => _AddTodoDialogCalendarState();
}

class _AddTodoDialogCalendarState extends State<AddTodoDialogCalendar> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isAllDay = false;
  int _color = Colors.blue.value;
  // 우선순위 필드가 필요하면 추가 가능
  // List<String>? _photoUrls = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("일정 추가"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "제목"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: "설명"),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text("하루 종일"),
                Switch(
                  value: _isAllDay,
                  onChanged: (val) {
                    setState(() {
                      _isAllDay = val;
                    });
                  },
                ),
              ],
            ),
            // 색상 선택 로직을 추가할 수 있음 (여기서는 고정값)
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("취소"),
        ),
        ElevatedButton(
          onPressed: () {
            if (_titleController.text.trim().isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("제목은 필수 항목입니다.")),
              );
              return;
            }
            final newTodo = TodoItem(
              id: null,
              isAllDay: _isAllDay,
              startDate: DateTime.now(), // 일단 임시로 설정, View에서 수정
              endDate: DateTime.now(), // 일단 임시로 설정, View에서 수정
              title: _titleController.text.trim(),
              description: _descriptionController.text.trim(),
              color: _color,
              photoUrls: [],
            );
            Navigator.of(context).pop(newTodo);
          },
          child: const Text("추가"),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
