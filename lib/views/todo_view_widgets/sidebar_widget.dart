import 'package:flutter/material.dart';
import 'package:modern_todo/core/theme/app_theme.dart';
import 'package:modern_todo/core/theme/color_palette.dart';
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
            child: SidebarTabItem(
              label: 'settings',
              color: AppColors.backgroundMistBlue,
              onTap: () {},
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
