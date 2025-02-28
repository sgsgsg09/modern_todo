import 'package:flutter/material.dart';
import 'package:modern_todo/core/theme/app_theme.dart';
import 'package:modern_todo/core/theme/color_palette.dart';
import 'package:modern_todo/views/calendar_view.dart';

class HeaderWidget extends StatelessWidget {
  final DateTime currentDate;
  final VoidCallback onCalendarPressed;

  const HeaderWidget({
    Key? key,
    required this.currentDate,
    required this.onCalendarPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final monthName = _monthName(currentDate.month); // 예: 7 → "July"
    final day = currentDate.day; // 예: 4 → 4
    final weekday = _dayOfWeek(currentDate.weekday); // 예: 월요일 → "Mon"

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      // child 프로퍼티를 통해 Column을 자식으로 배치
      child: Column(
        children: [
          // 두 번째 줄: 오른쪽 정렬 (캘린더 아이콘)
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                // 📌 여기에서 화면 이동을 수행
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CalendarView(), // 캘린더 화면 이동
                  ),
                );
              },
              icon: const Icon(
                Icons.calendar_month,
                color: AppColors.textPrimary,
                size: 30,
              ),
            ),
          ),
          // 첫 번째 줄: 왼쪽 정렬 (월/일.요일)
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  monthName,
                  style: AppTheme.headerSubtitleStyle,
                ),
                Text(
                  '$day.$weekday',
                  style: AppTheme.headerTitleStyle,
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey, // 구분선 색상
            thickness: 1, // 선 두께
            height: 20, // 위아래 여백 포함한 높이
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
    // 1 = 월요일이므로 인덱스 보정을 위해 (weekday - 1) % 7
    return weekdays[(weekday - 1) % 7];
  }
}
