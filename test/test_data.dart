import 'package:modern_todo/models/task.dart';

class TestData {
  final List<TodoItem> _mockTodoList = [
    TodoItem(
      date: DateTime(2025, 1, 31),
      title: '회의 준비',
      description: '팀 회의를 위한 자료 준비',
      color: 0xFFFFA500, // 주황색
      priority: 1, // 높음
    ),
    TodoItem(
      date: DateTime(2025, 2, 1),
      title: '프로젝트 코드 리뷰',
      description: '프로젝트 코드 리뷰 및 피드백 작성',
      color: 0xFF00FF00, // 초록색
      priority: 2, // 보통
    ),
    TodoItem(
      date: DateTime(2025, 2, 2),
      title: '기술 블로그 작성',
      description: '기술 블로그 초안 작성',
      color: 0xFF0000FF, // 파란색
      priority: 3, // 낮음
    ),
  ];
}
