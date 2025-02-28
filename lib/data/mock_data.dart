import 'package:flutter/material.dart';
import 'package:modern_todo/models/task.dart';
import 'package:modern_todo/models/task_category.dart';

// 미리 정의한 TaskCategory 인스턴스들 (별도 관리 화면 등에서 CRUD 가능)
final mockCategorys = <TaskCategory>[
  TaskCategory(
    id: 1,
    name: "Todo",
    colorValue: Colors.blue.value,
  ),
  TaskCategory(
    id: 2,
    name: "Routine",
    colorValue: Colors.orange.value,
  ),
];

// 수정된 Task 모델에서는 category 대신 categoryId를 사용
final mockTasks = <Task>[
  Task(
    id: 1,
    title: "집 청소하기",
    isCompleted: false,
    date: DateTime(2025, 2, 28),
    startTime: const TimeOfDay(hour: 10, minute: 0),
    durationInMinutes: 60,
    categoryId: 1,
    colorValue: Colors.purple.value,
    notes: "방, 거실, 주방 순으로 청소하기",
    photoUrls: ["https://example.com/images/clean_room.jpg"],
  ),
  Task(
    id: 2,
    title: "보고서 마무리하기",
    isCompleted: false,
    date: DateTime(2025, 2, 28),
    startTime: const TimeOfDay(hour: 13, minute: 30),
    durationInMinutes: 90,
    categoryId: 1,
    colorValue: Colors.blue.value,
    notes: "주간 업무 보고서 최종 검수",
    photoUrls: [],
  ),
  Task(
    id: 3,
    title: "장보기",
    isCompleted: false,
    date: DateTime(2025, 2, 28),
    startTime: const TimeOfDay(hour: 17, minute: 0),
    durationInMinutes: 30,
    categoryId: 1,
    colorValue: Colors.green.value,
    notes: "채소, 과일, 생필품 구매",
    photoUrls: ["https://example.com/images/grocery.jpg"],
  ),
  Task(
    id: 4,
    title: "저녁 운동",
    isCompleted: true,
    date: DateTime(2025, 2, 28),
    startTime: const TimeOfDay(hour: 19, minute: 0),
    durationInMinutes: 60,
    categoryId: 2,
    colorValue: Colors.orange.value,
    notes: "30분 러닝 + 30분 근력 운동",
    photoUrls: [],
  ),
  Task(
    id: 5,
    title: "친구와 약속",
    isCompleted: false,
    date: DateTime(2025, 2, 28),
    startTime: const TimeOfDay(hour: 18, minute: 0),
    durationInMinutes: 120,
    categoryId: 2,
    colorValue: Colors.red.value,
    notes: "카페에서 만남 후 저녁 식사 예정",
    photoUrls: [],
  ),
  Task(
    id: 6,
    title: "개인 프로젝트 아이디어 정리 아따 나도 모르겄다잉",
    isCompleted: false,
    date: DateTime(2025, 2, 28),
    startTime: const TimeOfDay(hour: 20, minute: 0),
    durationInMinutes: 45,
    categoryId: 2,
    colorValue: Colors.pink.value,
    notes: "노트 앱에 아이디어 간단히 정리하기",
    photoUrls: [],
  ),
];
