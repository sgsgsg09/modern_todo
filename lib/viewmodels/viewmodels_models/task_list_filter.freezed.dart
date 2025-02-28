// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_list_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TaskListFilter {
  DateTime get selectedDate => throw _privateConstructorUsedError;
  int? get selectedCategoryId => throw _privateConstructorUsedError;

  /// Create a copy of TaskListFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskListFilterCopyWith<TaskListFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskListFilterCopyWith<$Res> {
  factory $TaskListFilterCopyWith(
          TaskListFilter value, $Res Function(TaskListFilter) then) =
      _$TaskListFilterCopyWithImpl<$Res, TaskListFilter>;
  @useResult
  $Res call({DateTime selectedDate, int? selectedCategoryId});
}

/// @nodoc
class _$TaskListFilterCopyWithImpl<$Res, $Val extends TaskListFilter>
    implements $TaskListFilterCopyWith<$Res> {
  _$TaskListFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskListFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = null,
    Object? selectedCategoryId = freezed,
  }) {
    return _then(_value.copyWith(
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      selectedCategoryId: freezed == selectedCategoryId
          ? _value.selectedCategoryId
          : selectedCategoryId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskListFilterImplCopyWith<$Res>
    implements $TaskListFilterCopyWith<$Res> {
  factory _$$TaskListFilterImplCopyWith(_$TaskListFilterImpl value,
          $Res Function(_$TaskListFilterImpl) then) =
      __$$TaskListFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime selectedDate, int? selectedCategoryId});
}

/// @nodoc
class __$$TaskListFilterImplCopyWithImpl<$Res>
    extends _$TaskListFilterCopyWithImpl<$Res, _$TaskListFilterImpl>
    implements _$$TaskListFilterImplCopyWith<$Res> {
  __$$TaskListFilterImplCopyWithImpl(
      _$TaskListFilterImpl _value, $Res Function(_$TaskListFilterImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskListFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = null,
    Object? selectedCategoryId = freezed,
  }) {
    return _then(_$TaskListFilterImpl(
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      selectedCategoryId: freezed == selectedCategoryId
          ? _value.selectedCategoryId
          : selectedCategoryId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$TaskListFilterImpl implements _TaskListFilter {
  const _$TaskListFilterImpl(
      {required this.selectedDate, this.selectedCategoryId});

  @override
  final DateTime selectedDate;
  @override
  final int? selectedCategoryId;

  @override
  String toString() {
    return 'TaskListFilter(selectedDate: $selectedDate, selectedCategoryId: $selectedCategoryId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskListFilterImpl &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            (identical(other.selectedCategoryId, selectedCategoryId) ||
                other.selectedCategoryId == selectedCategoryId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, selectedDate, selectedCategoryId);

  /// Create a copy of TaskListFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskListFilterImplCopyWith<_$TaskListFilterImpl> get copyWith =>
      __$$TaskListFilterImplCopyWithImpl<_$TaskListFilterImpl>(
          this, _$identity);
}

abstract class _TaskListFilter implements TaskListFilter {
  const factory _TaskListFilter(
      {required final DateTime selectedDate,
      final int? selectedCategoryId}) = _$TaskListFilterImpl;

  @override
  DateTime get selectedDate;
  @override
  int? get selectedCategoryId;

  /// Create a copy of TaskListFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskListFilterImplCopyWith<_$TaskListFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
