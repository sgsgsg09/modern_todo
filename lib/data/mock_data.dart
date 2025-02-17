import 'package:flutter/material.dart';
import '../models/todo_item.dart';

List<TodoItem> getMockTodoItems() {
  return [
    // 1. 일반 미팅
    TodoItem(
      id: 1,
      isAllDay: false,
      startDate: DateTime(2025, 3, 20, 9, 0),
      endDate: DateTime(2025, 3, 20, 10, 0),
      title: "프로젝트 스탠드업 미팅",
      description: "팀과 진행 상황 점검 및 오늘의 할 일 논의",
      color: Colors.blue.value,
      photoUrls: [],
    ),
    // 2. 하루 종일 이벤트
    TodoItem(
      id: 2,
      isAllDay: true,
      startDate: DateTime(2025, 4, 5),
      endDate: DateTime(2025, 4, 5),
      title: "공휴일",
      description: "국경일로 인한 휴일, 휴식 및 재충전",
      color: Colors.green.value,
      photoUrls: [],
    ),
    // 3. 클라이언트 미팅 (사진 첨부 포함)
    TodoItem(
      id: 3,
      isAllDay: false,
      startDate: DateTime(2025, 3, 25, 14, 30),
      endDate: DateTime(2025, 3, 25, 16, 0),
      title: "클라이언트 미팅",
      description: "새로운 요구사항 논의를 위한 미팅. 장소: 회의실 A",
      color: Colors.orange.value,
      photoUrls: [
        "https://picsum.photos/250/250",
        "https://picsum.photos/250/250"
      ],
    ),
    // 4. 장기 여행 (여러 날에 걸친 하루 종일 이벤트)
    TodoItem(
      id: 4,
      isAllDay: true,
      startDate: DateTime(2025, 5, 1),
      endDate: DateTime(2025, 5, 7),
      title: "가족 여행",
      description: "해변과 산을 넘나드는 가족 여행",
      color: Colors.purple.value,
      photoUrls: [
        "https://example.com/images/vacation_1.jpg",
        "https://example.com/images/vacation_2.jpg"
      ],
    ),
    // 5. 외부 미팅
    TodoItem(
      id: 5,
      isAllDay: false,
      startDate: DateTime(2025, 3, 28, 11, 0),
      endDate: DateTime(2025, 3, 28, 12, 30),
      title: "외부 협력업체 미팅",
      description: "프로젝트 진행을 위한 외부 미팅. 장소: 본사 회의실",
      color: Colors.red.value,
      photoUrls: [],
    ),
  ];
}
