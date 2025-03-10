import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo/core/theme/app_theme.dart';
import 'package:modern_todo/core/theme/color_palette.dart';
import 'package:modern_todo/main.dart';
import 'package:modern_todo/models/task_category.dart';

/// 왼쪽 사이드 탭 위젯
class SidebarWidget extends StatelessWidget {
  final List<TaskCategory> categories;
  final TaskCategory? selectedCategory;
  final Function(TaskCategory?) onCategorySelected;

  const SidebarWidget({
    Key? key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 가로 폭
    const double sidebarWidth = 80;

    return Container(
      width: sidebarWidth,
      color: AppColors.primary, // 딥 그린 색.
      child: Column(
        children: [
          /// 1) 상단 탭들(전체 + 각 카테고리)
          Expanded(
            flex: 3,
            child: Column(
              children: [
                // "전체" 탭
                Expanded(
                  child: SidebarTabItem(
                    label: 'All',
                    color: AppColors.CategoryAll,
                    onTap: () => onCategorySelected(null),
                    isSelected: selectedCategory == null,
                    borderRadius: const BorderRadius.only(
                      // topLeft를 0으로 설정하여 둥근 모서리 제거
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                ),
                // 탭 사이 간격 1px
                Container(height: 1, color: Colors.transparent),

                // 카테고리 탭들
                ...categories.map((category) {
                  final bool isSelected = selectedCategory?.id == category.id;
                  return Expanded(
                    child: SidebarTabItem(
                      label: category.name,
                      color: Color(category.colorValue),
                      onTap: () => onCategorySelected(category),
                      isSelected: isSelected,
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          Spacer(flex: 2),

          /// 2) 맨 아래에 ‘Setting’ 탭 (최하단)
          // 최하단이므로 왼쪽 아래 모서리는 둥글지 않게 설정
          Expanded(
            flex: 1,
            // child: Container(),
            child: SidebarTabItem(
              label: 'settings',
              color: AppColors.backgroundMistBlue,
              onTap: () {
                // 'settings' 탭을 터치할 때 _showSideSheet 함수 호출
                _showSideSheet(context);
              },
              isSelected: false,
              borderRadius: const BorderRadius.only(
                // bottomLeft를 0으로 설정하여 둥근 모서리 제거
                topLeft: Radius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 각 사이드바 탭에 공통으로 쓰일 위젯
class SidebarTabItem extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;
  final bool isSelected;
  final BorderRadius? borderRadius;

  const SidebarTabItem({
    Key? key,
    required this.label,
    required this.color,
    required this.onTap,
    this.isSelected = false,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // 탭의 모서리 둥근 정도를 외부에서 주입받아 설정
        decoration: BoxDecoration(
          color: isSelected ? AppColors.selected : color,
          borderRadius: borderRadius ??
              const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
        ),
        child: Center(
          child: RotatedBox(
            quarterTurns: 3,
            child: Text(
              label,
              style: AppTheme.sidebarTitleStyle,
            ),
          ),
        ),
      ),
    );
  }
}

void _showSideSheet(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierLabel: "SideSheet",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.3),
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, _, __) {
      return Align(
        alignment: Alignment.centerRight,
        child: Material(
          color: Colors.transparent, // Material의 배경을 투명하게 설정

          elevation: 10,
          child: Container(
            width: 350,
            height: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
            ),
            child: Center(
              child: LanguageSelectionSheet(),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, anim, _, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(anim),
        child: child,
      );
    },
  );
}

class LanguageSelectionSheet extends ConsumerWidget {
  // 선택 가능한 언어 목록
  final List<Map<String, dynamic>> languages = [
    {"label": "日本語", "locale": const Locale('ja')},
    {"label": "English", "locale": const Locale('en')},
    {"label": "한국어", "locale": const Locale('ko')},
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 현재 선택된 Locale 상태를 읽어옴
    final currentLocale = ref.watch(localeProvider);
    return Container(
      width: 350,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: languages.map((language) {
          // 선택된 언어인지 체크
          final bool isSelected = currentLocale == language["locale"];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton(
              onPressed: () {
                // 전역 Locale 업데이트 (예: MyApp의 changeLocale 메서드 호출)
                MyApp.of(context)?.changeLocale(language["locale"]);
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith<Color>(
                  (Set<WidgetState> states) {
                    if (states.contains(WidgetState.pressed)) {
                      return AppColors.primary; // 버튼이 눌렸을 때 색상
                    }
                    // 선택된 언어는 강조 색상 사용 (예: 초록색), 아니면 기본 파란색
                    return isSelected
                        ? AppColors.primary
                        : AppColors.textSecondary;
                  },
                ),
                foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                minimumSize: WidgetStateProperty.all<Size>(
                    const Size(double.infinity, 50)),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // 둥근 모서리
                  ),
                ),
              ),
              child: Text(
                language["label"],
                style: const TextStyle(fontSize: 18),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
