import 'package:flutter/material.dart';
import 'package:modern_todo/models/todo_item.dart';
import 'package:modern_todo/core/theme/app_theme.dart';

class TodoCard extends StatelessWidget {
  final TodoItem todo;

  const TodoCard({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(todo.color).withOpacity(0.2),
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        title: Text(
          todo.title,
          style: AppTheme.todoTitleStyle,
        ),
        subtitle: Text(
          todo.description,
          style: AppTheme.todoDescriptionStyle,
        ),
        // 필요한 경우 trailing 아이콘 등을 추가할 수 있습니다.
      ),
    );
  }
}
