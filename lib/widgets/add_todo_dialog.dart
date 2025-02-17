import 'package:flutter/material.dart';
import 'package:modern_todo/models/todo_item.dart';

class AddTodoDialog extends StatefulWidget {
  const AddTodoDialog({Key? key}) : super(key: key);

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  int _color = 0xFFE3F2FD; // 기본 색상 (파스텔 블루)

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("새 Todo 추가"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 제목 입력
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "제목"),
            ),
            const SizedBox(height: 10),
            // 설명 입력
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: "설명"),
            ),
            const SizedBox(height: 10),
            // 날짜 선택
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "날짜: ${_selectedDate.toLocal().toString().split(' ')[0]}",
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  setState(() {
                    _selectedDate = picked;
                  });
                }
              },
            ),
            const SizedBox(height: 10),
            // 색상 선택 (향후 ColorPicker 등으로 확장 가능)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _color = 0xFFFFF9C4; // 임의의 파스텔 옐로
                });
              },
              child: const Text("색상 변경"),
            ),
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
              isAllDay: false,
              startDate: _selectedDate,
              endDate: _selectedDate,
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
