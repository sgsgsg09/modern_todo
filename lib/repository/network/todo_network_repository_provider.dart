import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo/repository/network/todo_network_repostitory.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:modern_todo/repository/todo_abstract_repository.dart';

part 'todo_network_repository_provider.g.dart';

@Riverpod(keepAlive: true)
TodoAbstractRepository todoNetworkRepository(Ref ref) {
  // API 서버의 URL이 필요하면 ref를 통해 환경변수를 받아오거나 별도 설정이 가능합니다.
  return TodoNetworkRepository(baseUrl: 'https://api.example.com');
}
