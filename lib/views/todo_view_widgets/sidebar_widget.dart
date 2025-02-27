import 'package:flutter/material.dart';
import 'package:modern_todo/core/theme/app_theme.dart';
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
      color: Colors.transparent, // 전체 배경 투명
      child: Column(
        children: [
          /// 1) 상단 탭들(전체 + 각 카테고리)
          Expanded(
            // Expanded나 SingleChildScrollView를 활용해 스크롤 가능하게 처리 가능
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // "전체" 탭
                GestureDetector(
                  onTap: () => onCategorySelected(null),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    width: sidebarWidth * 0.8,
                    height: 80,
                    decoration: BoxDecoration(
                      color: (selectedCategory == null)
                          ? Colors.grey.shade300
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: RotatedBox(
                        quarterTurns: 3, // 세로 회전
                        child: Text(
                          'All',
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // 카테고리 탭들
                ...categories.map((category) {
                  final isSelected = selectedCategory?.id == category.id;
                  return GestureDetector(
                    onTap: () => onCategorySelected(category),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      width: sidebarWidth * 0.8,
                      height: 80,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Color(category.colorValue).withOpacity(0.8)
                            : Color(category.colorValue),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: Text(
                            category.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),

          /// 2) 맨 아래에 ‘Setting’ 탭
          GestureDetector(
            onTap: () {
              // Setting 화면으로 이동하거나, 기능 실행
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              width: sidebarWidth * 0.8,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.purpleAccent, // 원하는 색상
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    'Settings',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
