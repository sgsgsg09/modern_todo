import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_list_filter.freezed.dart';

@freezed
class TaskListFilter with _$TaskListFilter {
  const factory TaskListFilter({
    required DateTime selectedDate,
    int? selectedCategoryId,
  }) = _TaskListFilter;
}
