// lib/theme/app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  // 색상 정의
  static const Color primaryColor = Color(0xFF0B3D02);
  static const Color accentColor = Color(0xFFFFC107);
  static const Color todoCardBackground = Color(0xFFE3F2FD);
  static const Color errorColor = Colors.red;
  static const Color greyColor = Colors.grey;

  //Header_widgets_style

  // 텍스트 스타일 정의
  static final TextStyle headerTitleStyle = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  );

  static final TextStyle headerSubtitleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  );
  static final TextStyle sidebarTitleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Color(0xFF0B3D02),
  );
  static final TextStyle todoTitleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Color(0xFF0B3D02),
  );

  static final TextStyle todoDescriptionStyle = TextStyle(
    fontSize: 14,
    color: const Color.fromARGB(221, 52, 52, 52),
  );

  static final TextStyle addTodoTextStyle = TextStyle(
    fontSize: 16,
    color: greyColor,
  );
}
