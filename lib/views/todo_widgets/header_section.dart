import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modern_todo/core/theme/app_theme.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dayName = DateFormat('EEEE').format(now); // 예: Thursday
    final dayNumber = DateFormat('d').format(now); // 예: 25
    final monthName = DateFormat('MMMM').format(now); // 예: January

    return Container(
      margin: EdgeInsets.all(10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 229, 163, 255),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        child: IntrinsicHeight(
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// 왼쪽 영역: 날짜 정보
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dayName,
                        style: AppTheme.today_headerTitleStyle
                            .copyWith(fontSize: 22),
                      ),
                      Text(
                        dayNumber,
                        style: AppTheme.today_headerTitleStyle.copyWith(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        monthName.toUpperCase(),
                        style: AppTheme.today_headerSubtitleStyle.copyWith(
                          fontSize: 16,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),

                /// 구분선
                const VerticalDivider(
                  width: 10,
                  thickness: 1,
                  color: Color.fromARGB(255, 196, 196, 196),
                  indent: 8,
                  endIndent: 8,
                ),

                /// 오른쪽 영역: “다음 일정까지 남은 시간” 박스
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "다음 일정까지 남은 시간",
                        style: AppTheme.today_headerSubtitleStyle.copyWith(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "02:30",
                        style: AppTheme.headerTitleStyle.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
