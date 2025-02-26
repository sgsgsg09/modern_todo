import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';
import 'task_category.dart';

// build_runner가 생성할 파일들
part 'task.freezed.dart';
part 'task.g.dart';

// TimeOfDay <-> Map<String, int> 변환용 컨버터
class TimeOfDayConverter
    implements JsonConverter<TimeOfDay?, Map<String, int>?> {
  const TimeOfDayConverter();

  @override
  TimeOfDay? fromJson(Map<String, int>? json) {
    if (json == null) return null;
    return TimeOfDay(hour: json['hour']!, minute: json['minute']!);
  }

  @override
  Map<String, int>? toJson(TimeOfDay? object) {
    if (object == null) return null;
    return {'hour': object.hour, 'minute': object.minute};
  }
}

@freezed
class Task with _$Task {
  @JsonSerializable(explicitToJson: true)
  const factory Task({
    /// 고유 ID
    int? id,

    /// 할 일 제목
    required String title,

    /// 완료 여부
    @Default(false) bool isCompleted,

    /// 작업 날짜 (YYYY-MM-DD 형태만 사용하거나, DateTime 전체 사용)
    required DateTime date,

    /// 시작 시간 (필요 시)
    @TimeOfDayConverter() TimeOfDay? startTime,

    /// 예상 소요 시간(분 단위 등으로 저장해도 됨)
    int? durationInMinutes,

    /// 분류(예: todo, routine, event, my)
    @TaskCategoryConverter() required TaskCategory category,

    /// 색상 값 (예: Colors.blue.value)
    int? colorValue,

    /// 추가 메모
    String? notes,

    /// 첨부 이미지 목록
    List<String>? photoUrls,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}

class TaskCategoryConverter
    implements JsonConverter<TaskCategory, Map<String, dynamic>> {
  const TaskCategoryConverter();

  @override
  TaskCategory fromJson(Map<String, dynamic> json) {
    return TaskCategory(
      id: json['id'] as int,
      name: json['name'] as String,
      colorValue: json['colorValue'] as int,
    );
  }

  @override
  Map<String, dynamic> toJson(TaskCategory object) {
    return <String, dynamic>{
      'id': object.id,
      'name': object.name,
      'colorValue': object.colorValue,
    };
  }
}
