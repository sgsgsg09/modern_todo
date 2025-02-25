import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo/todo_cards/todo_card.dart';
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

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Column(
          children: [
            // 상단: 어두운 배경에 달력 표시
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
                  // CalendarViewModel의 getEventsForDay 사용
                  eventLoader: (day) =>
                      CalendarViewModel.getEventsForDay(day, todos),
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
                    final events =
                        CalendarViewModel.getEventsForDay(_selectedDay, todos);
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
}
