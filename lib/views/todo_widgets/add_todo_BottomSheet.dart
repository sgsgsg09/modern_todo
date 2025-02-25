import 'package:flutter/material.dart';
import 'package:modern_todo/models/task.dart';

class AddTodoBottomSheet extends StatefulWidget {
  const AddTodoBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddTodoBottomSheet> createState() => _AddTodoBottomSheetState();
}

class _AddTodoBottomSheetState extends State<AddTodoBottomSheet> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // 시작 날짜와 종료 날짜는 기본적으로 현재 날짜 및 시간
  DateTime _selectedStartDate = DateTime.now();
  DateTime _selectedEndDate = DateTime.now();
  int _selectedColor = Colors.blue.value;
  bool _isAllDay = false;

  // 10가지 색상 옵션
  final List<int> _availableColors = [
    Colors.blue.value,
    Colors.red.value,
    Colors.green.value,
    Colors.orange.value,
    Colors.purple.value,
    Colors.pink.value,
    Colors.cyan.value,
    Colors.amber.value,
    Colors.lime.value,
    Colors.teal.value,
  ];

  Future<void> _pickStartDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedStartDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        // 만약 시간을 별도로 선택하지 않으면 현재 시간을 기본값으로 사용
        final now = DateTime.now();
        _selectedStartDate = DateTime(
          picked.year,
          picked.month,
          picked.day,
          _isAllDay ? 0 : now.hour,
          _isAllDay ? 0 : now.minute,
        );
        if (_isAllDay) {
          _selectedEndDate = _selectedStartDate;
        }
      });
    }
  }

  Future<void> _pickEndDate() async {
    // 하루 종일 선택 시 종료 날짜는 시작 날짜와 동일하므로 선택 불가
    if (_isAllDay) return;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedEndDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        final now = DateTime.now();
        _selectedEndDate = DateTime(
          picked.year,
          picked.month,
          picked.day,
          now.hour,
          now.minute,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // 키보드가 올라올 때 아래 공간 확보
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(16),
        // 화면의 75%까지 높이를 제한하여 기존 화면보다 작게 보이게 함
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
          minHeight: MediaQuery.of(context).size.height * 0.70,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "일정 추가하기",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              // 제목 입력
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "제목",
                ),
              ),
              const SizedBox(height: 10),
              // 설명 입력
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: "설명",
                ),
              ),
              const SizedBox(height: 10),
              // 하루 종일 토글
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text("하루 종일"),
                  Switch(
                    value: _isAllDay,
                    onChanged: (val) {
                      setState(() {
                        _isAllDay = val;
                        if (_isAllDay) {
                          // 하루 종일 선택 시 시작 날짜와 종료 날짜를 동일하게 설정
                          _selectedEndDate = _selectedStartDate;
                        }
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // 시작 날짜 선택
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "시작 날짜: ${_selectedStartDate.toLocal().toString().split(' ')[0]}",
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickStartDate,
              ),
              if (!_isAllDay)
                // 종료 날짜 선택 (하루 종일이면 표시하지 않음)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    "종료 날짜: ${_selectedEndDate.toLocal().toString().split(' ')[0]}",
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: _pickEndDate,
                ),
              const SizedBox(height: 10),
              // 색상 선택 (10가지 옵션)
              SizedBox(
                height: 50,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  itemCount: _availableColors.length,
                  itemBuilder: (context, index) {
                    final color = _availableColors[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColor = color;
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(color),
                          shape: BoxShape.circle,
                          border: _selectedColor == color
                              ? Border.all(color: Colors.black, width: 2)
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              // 사진 첨부 기능 (추후 구현할 경우 아래 버튼의 주석을 해제)
              // ElevatedButton(
              //   onPressed: () {
              //     // 사진 첨부 로직 구현
              //   },
              //   child: const Text("사진 첨부"),
              // ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                      // 기본값 적용: 별도로 시간 설정하지 않으면 현재 시간이 사용됨
                      final startDate = _selectedStartDate;
                      final endDate =
                          _isAllDay ? _selectedStartDate : _selectedEndDate;
                      final newTodo = TodoItem(
                        id: null,
                        isAllDay: _isAllDay,
                        startDate: startDate,
                        endDate: endDate,
                        title: _titleController.text.trim(),
                        description: _descriptionController.text.trim(),
                        color: _selectedColor,
                        // 사진 첨부 기능 구현 시 photoUrls 값을 채워줌
                        photoUrls: [],
                      );
                      Navigator.of(context).pop(newTodo);
                    },
                    child: const Text("추가"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
