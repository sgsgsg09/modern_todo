import 'package:modern_todo/models/task.dart';
import 'package:modern_todo/repository/local/todo_hive_repository.dart';
import 'package:modern_todo/repository/remote/todo_remote_repository.dart';

class TodoSyncManager {
  final TodoHiveRepository localRepo;
  final TodoRemoteRepository remoteRepo;

  TodoSyncManager({
    required this.localRepo,
    required this.remoteRepo,
  });

  Future<void> addTodo(Task todo) async {
    // 1. 로컬 업데이트: 빠른 캐시 반영
    await localRepo.addTodo(todo);

    // 2. 네트워크 동기화: 실패 시 재시도 로직 추가 고려
    try {
      await remoteRepo.addTodo(todo);
    } catch (error) {
      print("AddTodo sync failed: $error");
      // 재시도 큐에 추가하거나 에러 로깅 등 추가 처리
    }
  }

  Future<void> updateTodo(Task todo) async {
    await localRepo.updateTodo(todo);
    try {
      await remoteRepo.updateTodo(todo);
    } catch (error) {
      print("UpdateTodo sync failed: $error");
    }
  }

  Future<void> deleteTodo(Task todo) async {
    await localRepo.deleteTodo(todo);
    try {
      await remoteRepo.deleteTodo(todo);
    } catch (error) {
      print("DeleteTodo sync failed: $error");
    }
  }

  Future<List<Task>> fetchTodos({DateTime? date}) async {
    // 빠른 사용자 경험을 위해 먼저 로컬 데이터를 반환
    final localTodos = await localRepo.fetchTodos(date: date);

    // 별도 동기화 로직으로 최신 데이터를 백그라운드에서 업데이트 할 수 있음
    // 예: remoteRepo.fetchTodos() 호출 후 로컬 업데이트 후 UI 갱신

    return localTodos;
  }
}
