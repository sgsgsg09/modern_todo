import 'dart:async'; // Timer 사용을 위해 추가
import 'package:flutter/material.dart';
import 'package:modern_todo/models/todo_item.dart';
import 'package:modern_todo/core/theme/app_theme.dart';

class TodoCard extends StatefulWidget {
  final TodoItem todo;

  const TodoCard({Key? key, required this.todo}) : super(key: key);

  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  late Timer _timer;
  late Duration _remainingTime;

  @override
  void initState() {
    super.initState();
    _updateRemainingTime();

    // 1초마다 남은 시간 업데이트
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _updateRemainingTime();
        });
      }
    });
  }

  void _updateRemainingTime() {
    final now = DateTime.now();
    _remainingTime = widget.todo.startDate.difference(now);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    if (duration.isNegative) {
      return "시간 초과";
    }

    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return "$hours시간 $minutes분 남음";
    } else if (minutes > 0) {
      return "$minutes분 $seconds초 남음";
    } else {
      return "$seconds초 남음";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(
            color: Color(widget.todo.color),
            width: 5,
          ),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.047),
            offset: Offset(0, 1),
            blurRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 왼쪽: title & subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.todo.title.length > 10
                        ? widget.todo.description.substring(0, 10) + '...'
                        : widget.todo.description,
                    style: AppTheme.todoTitleStyle,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.todo.description.length > 15
                        ? widget.todo.description.substring(0, 15) + '...'
                        : widget.todo.description,
                    style: AppTheme.todoDescriptionStyle,
                  ),
                ],
              ),
            ),
            // 오른쪽: 남은 시간
            Text(
              _formatDuration(_remainingTime),
              style: TextStyle(
                color: Color(widget.todo.color),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
