import 'package:modern_todo/models/task.dart';
import 'package:modern_todo/models/task_category.dart';

abstract class TodoAbstractRepository {
  /// 날짜가 null이면 전체 Todo를 반환하고, 날짜가 주어지면 해당 날짜의 Todo를 반환합니다.
  Future<List<Task>> fetchTodos({DateTime? date});

  Future<void> addTodo(Task todo);
  Future<void> updateTodo(Task todo);
  Future<void> deleteTodo(Task todo);

  // 새로 추가: 전체 카테고리를 가져오는 메서드
  Future<List<TaskCategory>> fetchCategories();

  // 혹은 특정 ID에 해당하는 카테고리를 가져오는 메서드
  Future<TaskCategory?> fetchCategoryById(int id);
}

/*
	•	데이터 소스(여기서는 메모리 내 mock 데이터)를 관리합니다.
	•	날짜 필터나 CRUD(생성, 수정, 삭제) 작업을 수행하며, ViewModel에서는 이 Repository 인터페이스에만 의존하므로 나중에 Supabase 등 다른 데이터 소스로 쉽게 전환할 수 있습니다.

  TodoAbstractRepository는 실제 구현체가 아니기 때문에 provider를 직접 만들 필요는 없습니다. 대신, 이 인터페이스를 구현한 구체적인 클래스들(예: TodoMockRepository, TodoLocalRepository, TodoNetworkRepository)에 대해 provider를 생성하여 앱 내에서 의존성 주입을 수행합니다.
*/