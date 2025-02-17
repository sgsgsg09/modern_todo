import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'todo_item.freezed.dart';
part 'todo_item.g.dart';

@freezed
class TodoItem with _$TodoItem {
  @JsonSerializable(explicitToJson: true)
  factory TodoItem({
    /// Supabase에서 자동 생성하는 id (없을 수 있으므로 nullable)
    int? id,

    /// 하루 종일 여부
    required bool isAllDay,

    /// 시작 날짜 (년.월.일)
    required DateTime startDate,

    /// 종료 날짜 (년.월.일)
    required DateTime endDate,

    /// 항목 제목
    required String title,

    /// 설명 텍스트
    required String description,

    /// 색상 값 (예, Colors.blue.value)
    required int color,

    /// 사진 첨부 URL 목록 (여러 장의 사진 첨부 가능)
    List<String>? photoUrls,
  }) = _TodoItem;

  factory TodoItem.fromJson(Map<String, dynamic> json) =>
      _$TodoItemFromJson(json);
}
