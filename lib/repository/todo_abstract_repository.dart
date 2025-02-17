import 'package:modern_todo/models/todo_item.dart';

abstract class TodoAbstractRepository {
  /// 날짜가 null이면 전체 Todo를 반환하고, 날짜가 주어지면 해당 날짜의 Todo를 반환합니다.
  Future<List<TodoItem>> fetchTodos({DateTime? date});

  Future<void> addTodo(TodoItem todo);
  Future<void> updateTodo(TodoItem todo);
  Future<void> deleteTodo(TodoItem todo);
}

/*
	•	데이터 소스(여기서는 메모리 내 mock 데이터)를 관리합니다.
	•	날짜 필터나 CRUD(생성, 수정, 삭제) 작업을 수행하며, ViewModel에서는 이 Repository 인터페이스에만 의존하므로 나중에 Supabase 등 다른 데이터 소스로 쉽게 전환할 수 있습니다.
*/