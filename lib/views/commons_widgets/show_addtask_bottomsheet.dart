import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modern_todo/core/theme/app_theme.dart';
import 'package:modern_todo/core/theme/color_palette.dart';
import 'package:modern_todo/models/task.dart';
import 'package:modern_todo/models/task_category.dart';

///
/// 바텀시트를 띄우고, 새로 생성된 Task를 반환받는 함수
///
Future<Task?> showAddTaskBottomSheet({
  required BuildContext context,
  required List<TaskCategory> categories,
  Task? existingTask, // 추가: 수정할 Task를 받을 수 있도록 파라미터 추가
}) async {
  return showModalBottomSheet<Task?>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) {
      return _AddTaskBottomSheetContent(
        categories: categories,
        existingTask: existingTask, // 함께 넘겨줌
      );
    },
  );
}

///
/// 바텀시트 내부 UI
/// - 날짜·시간 선택, 제목·메모 입력, 카테고리/색상 선택, 알람 설정 등
///
class _AddTaskBottomSheetContent extends StatefulWidget {
  final List<TaskCategory> categories;
  final Task? existingTask; // 수정할 Task

  const _AddTaskBottomSheetContent({
    Key? key,
    required this.categories,
    this.existingTask, // nullable
  }) : super(key: key);

  @override
  State<_AddTaskBottomSheetContent> createState() =>
      _AddTaskBottomSheetContentState();
}

class _AddTaskBottomSheetContentState
    extends State<_AddTaskBottomSheetContent> {
  final _formKey = GlobalKey<FormState>();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay? _selectedTime;
  String _title = '';
  String _notes = '';
  int? _selectedCategoryId;
  int? _selectedColorValue;
  bool _hasAlarm = false; // 알람 설정 여부

  @override
  void initState() {
    super.initState();
    // 만약 existingTask가 있다면(== 수정 모드라면), 기존 Task의 값을 불러와 폼 필드에 초기화
    final existingTask = widget.existingTask;
    if (existingTask != null) {
      _selectedDate = existingTask.date;
      _selectedTime = existingTask.startTime;
      _title = existingTask.title;
      _notes = existingTask.notes ?? '';
      _selectedCategoryId = existingTask.categoryId;
      _selectedColorValue = existingTask.colorValue;
      // _hasAlarm = ... (필요시)
    } else {
      // 추가할 때만 동작할 로직
      if (widget.categories.isNotEmpty) {
        _selectedCategoryId = widget.categories.first.id;
        _selectedColorValue = widget.categories.first.colorValue;
      }
    }
  }

  Future<void> _pickDate() async {
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
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _saveTask() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      final newTask = Task(
        id: null,
        title: _title,
        isCompleted: false,
        date: _selectedDate,
        startTime: _selectedTime,
        durationInMinutes: null,
        categoryId: _selectedCategoryId ?? 0,
        colorValue: _selectedColorValue,
        notes: _notes.isEmpty ? null : _notes,
      );

      Navigator.pop(context, newTask);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        top: 16,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 날짜·시간 선택 영역 (Card 스타일 제거, 구분선 추가)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date & Time', style: AppTheme.todoTitleStyle),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: _pickDate,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.borderColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${_selectedDate.month}월 ${_selectedDate.day}일',
                              style: AppTheme.todoDescriptionStyle,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          onTap: _pickTime,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.borderColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              _selectedTime != null
                                  ? _selectedTime!.format(context)
                                  : '시간 설정',
                              style: AppTheme.todoDescriptionStyle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 16),

            // 제목 입력 영역
            Text('Title', style: AppTheme.todoTitleStyle),
            const SizedBox(height: 4),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              // 기존 Task 제목을 UI에 표시해주기 위해 추가:
              initialValue: _title,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return '제목을 입력하세요';
                }
                return null;
              },
              onSaved: (value) => _title = value ?? '',
            ),
            const SizedBox(height: 16),
// 카테고리 선택 영역 (가로 방향 배치)
            if (widget.categories.isNotEmpty) ...[
              Text('카테고리', style: AppTheme.todoTitleStyle),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: widget.categories.map((cat) {
                  final isSelected = _selectedCategoryId == cat.id;
                  return ChoiceChip(
                    label: Text(cat.name),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedCategoryId = cat.id;
                          _selectedColorValue = cat.colorValue;
                        });
                      }
                    },
                    selectedColor: AppTheme.accentColor,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
            ],
            // 메모 입력 영역
            Text('Notes', style: AppTheme.todoTitleStyle),
            const SizedBox(height: 4),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Notes',
                border: OutlineInputBorder(),
              ),
              initialValue: _notes,
              maxLines: 3,
              onSaved: (value) => _notes = value ?? '',
            ),
            const SizedBox(height: 8),
            const Divider(thickness: 1),
            // 색상 선택 영역
            if (_selectedColorValue != null) ...[
              Text('색상 선택', style: AppTheme.todoTitleStyle),
              const SizedBox(height: 8),
              Row(
                children: [
                  for (final colorVal in [
                    Colors.red.value,
                    Colors.yellow.value,
                    Colors.green.value,
                    Colors.blue.value,
                  ])
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColorValue = colorVal;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Color(colorVal),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _selectedColorValue == colorVal
                                ? AppTheme.accentColor
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
            ],

            // 알람 설정 영역
            /* Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('알람 설정', style: AppTheme.todoTitleStyle),
                Switch(
                  value: _hasAlarm,
                  onChanged: (value) {
                    setState(() {
                      _hasAlarm = value;
                    });
                  },
                  activeColor: AppTheme.accentColor,
                ),
              ],
            ), */
            const SizedBox(height: 16),

            // 저장 / 삭제 버튼 Row
            Row(
              children: [
                // SAVE 버튼
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.accentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: _saveTask,
                    child: const Text('Save'),
                  ),
                ),
                const SizedBox(width: 8),
                // DELETE 버튼 (기존 Task가 있을 때만 보이도록)
                if (widget.existingTask != null)
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        // 삭제 로직 구현
                        // 예: provider를 통해 삭제를 처리하고, 바텀시트를 닫기
                        // ref.read(taskViewModelProvider.notifier).deleteTask(widget.existingTask!);
                        Navigator.pop(context, 'delete'); // 삭제 완료 후 삭제 신호 전달
                      },
                      child: const Text('Delete'),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
