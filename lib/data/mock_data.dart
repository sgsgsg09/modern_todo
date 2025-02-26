import 'package:flutter/material.dart';
import 'package:modern_todo/models/task.dart';
import 'package:modern_todo/models/task_category.dart';

// 미리 정의한 TaskCategory 인스턴스들 (필요에 따라 사용자가 추가/수정할 수 있도록 별도의 화면에서 관리 가능)
final TaskCategory todoCategory = TaskCategory(
  id: 1,
  name: "Todo",
  colorValue: Colors.blue.value,
);

final TaskCategory routineCategory = TaskCategory(
  id: 2,
  name: "Routine",
  colorValue: Colors.orange.value,
);

final TaskCategory eventCategory = TaskCategory(
  id: 3,
  name: "Event",
  colorValue: Colors.red.value,
);

final TaskCategory myCategory = TaskCategory(
  id: 4,
  name: "My",
  colorValue: Colors.pink.value,
);

final mockTasks = <Task>[
  Task(
    id: 1,
    title: "집 청소하기",
    isCompleted: false,
    date: DateTime(2023, 7, 4),
    startTime: const TimeOfDay(hour: 10, minute: 0),
    durationInMinutes: 60,
    category: todoCategory,
    colorValue: Colors.purple.value,
    notes: "방, 거실, 주방 순으로 청소하기",
    photoUrls: ["https://example.com/images/clean_room.jpg"],
  ),
  Task(
    id: 2,
    title: "보고서 마무리하기",
    isCompleted: false,
    date: DateTime(2023, 7, 4),
    startTime: const TimeOfDay(hour: 13, minute: 30),
    durationInMinutes: 90,
    category: todoCategory,
    colorValue: Colors.blue.value,
    notes: "주간 업무 보고서 최종 검수",
    photoUrls: [],
  ),
  Task(
    id: 3,
    title: "장보기",
    isCompleted: false,
    date: DateTime(2023, 7, 4),
    startTime: const TimeOfDay(hour: 17, minute: 0),
    durationInMinutes: 30,
    category: todoCategory,
    colorValue: Colors.green.value,
    notes: "채소, 과일, 생필품 구매",
    photoUrls: ["https://example.com/images/grocery.jpg"],
  ),
  Task(
    id: 4,
    title: "저녁 운동",
    isCompleted: true,
    date: DateTime(2023, 7, 4),
    startTime: const TimeOfDay(hour: 19, minute: 0),
    durationInMinutes: 60,
    category: routineCategory,
    colorValue: Colors.orange.value,
    notes: "30분 러닝 + 30분 근력 운동",
    photoUrls: [],
  ),
  Task(
    id: 5,
    title: "친구와 약속",
    isCompleted: false,
    date: DateTime(2023, 7, 5),
    startTime: const TimeOfDay(hour: 18, minute: 0),
    durationInMinutes: 120,
    category: eventCategory,
    colorValue: Colors.red.value,
    notes: "카페에서 만남 후 저녁 식사 예정",
    photoUrls: [],
  ),
  Task(
    id: 6,
    title: "개인 프로젝트 아이디어 정리",
    isCompleted: false,
    date: DateTime(2023, 7, 5),
    startTime: const TimeOfDay(hour: 20, minute: 0),
    durationInMinutes: 45,
    category: myCategory,
    colorValue: Colors.pink.value,
    notes: "노트 앱에 아이디어 간단히 정리하기",
    photoUrls: [],
  ),
];
