// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Task _$TaskFromJson(Map<String, dynamic> json) {
  return _Task.fromJson(json);
}

/// @nodoc
mixin _$Task {
  /// 고유 ID
  int? get id => throw _privateConstructorUsedError;

  /// 할 일 제목
  String get title => throw _privateConstructorUsedError;

  /// 완료 여부
  bool get isCompleted => throw _privateConstructorUsedError;

  /// 작업 날짜 (YYYY-MM-DD 형태만 사용하거나, DateTime 전체 사용)
  DateTime get date => throw _privateConstructorUsedError;

  /// 시작 시간 (필요 시)
  @TimeOfDayConverter()
  TimeOfDay? get startTime => throw _privateConstructorUsedError;

  /// 예상 소요 시간(분 단위 등으로 저장해도 됨)
  int? get durationInMinutes => throw _privateConstructorUsedError;

  /// 분류(예: todo, routine, event, my)
  @TaskCategoryConverter()
  TaskCategory get category => throw _privateConstructorUsedError;

  /// 색상 값 (예: Colors.blue.value)
  int? get colorValue => throw _privateConstructorUsedError;

  /// 추가 메모
  String? get notes => throw _privateConstructorUsedError;

  /// 첨부 이미지 목록
  List<String>? get photoUrls => throw _privateConstructorUsedError;

  /// Serializes this Task to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskCopyWith<Task> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskCopyWith<$Res> {
  factory $TaskCopyWith(Task value, $Res Function(Task) then) =
      _$TaskCopyWithImpl<$Res, Task>;
  @useResult
  $Res call(
      {int? id,
      String title,
      bool isCompleted,
      DateTime date,
      @TimeOfDayConverter() TimeOfDay? startTime,
      int? durationInMinutes,
      @TaskCategoryConverter() TaskCategory category,
      int? colorValue,
      String? notes,
      List<String>? photoUrls});
}

/// @nodoc
class _$TaskCopyWithImpl<$Res, $Val extends Task>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? isCompleted = null,
    Object? date = null,
    Object? startTime = freezed,
    Object? durationInMinutes = freezed,
    Object? category = null,
    Object? colorValue = freezed,
    Object? notes = freezed,
    Object? photoUrls = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
      durationInMinutes: freezed == durationInMinutes
          ? _value.durationInMinutes
          : durationInMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as TaskCategory,
      colorValue: freezed == colorValue
          ? _value.colorValue
          : colorValue // ignore: cast_nullable_to_non_nullable
              as int?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrls: freezed == photoUrls
          ? _value.photoUrls
          : photoUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskImplCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$$TaskImplCopyWith(
          _$TaskImpl value, $Res Function(_$TaskImpl) then) =
      __$$TaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String title,
      bool isCompleted,
      DateTime date,
      @TimeOfDayConverter() TimeOfDay? startTime,
      int? durationInMinutes,
      @TaskCategoryConverter() TaskCategory category,
      int? colorValue,
      String? notes,
      List<String>? photoUrls});
}

/// @nodoc
class __$$TaskImplCopyWithImpl<$Res>
    extends _$TaskCopyWithImpl<$Res, _$TaskImpl>
    implements _$$TaskImplCopyWith<$Res> {
  __$$TaskImplCopyWithImpl(_$TaskImpl _value, $Res Function(_$TaskImpl) _then)
      : super(_value, _then);

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? isCompleted = null,
    Object? date = null,
    Object? startTime = freezed,
    Object? durationInMinutes = freezed,
    Object? category = null,
    Object? colorValue = freezed,
    Object? notes = freezed,
    Object? photoUrls = freezed,
  }) {
    return _then(_$TaskImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
      durationInMinutes: freezed == durationInMinutes
          ? _value.durationInMinutes
          : durationInMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as TaskCategory,
      colorValue: freezed == colorValue
          ? _value.colorValue
          : colorValue // ignore: cast_nullable_to_non_nullable
              as int?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrls: freezed == photoUrls
          ? _value._photoUrls
          : photoUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$TaskImpl implements _Task {
  const _$TaskImpl(
      {this.id,
      required this.title,
      this.isCompleted = false,
      required this.date,
      @TimeOfDayConverter() this.startTime,
      this.durationInMinutes,
      @TaskCategoryConverter() required this.category,
      this.colorValue,
      this.notes,
      final List<String>? photoUrls})
      : _photoUrls = photoUrls;

  factory _$TaskImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskImplFromJson(json);

  /// 고유 ID
  @override
  final int? id;

  /// 할 일 제목
  @override
  final String title;

  /// 완료 여부
  @override
  @JsonKey()
  final bool isCompleted;

  /// 작업 날짜 (YYYY-MM-DD 형태만 사용하거나, DateTime 전체 사용)
  @override
  final DateTime date;

  /// 시작 시간 (필요 시)
  @override
  @TimeOfDayConverter()
  final TimeOfDay? startTime;

  /// 예상 소요 시간(분 단위 등으로 저장해도 됨)
  @override
  final int? durationInMinutes;

  /// 분류(예: todo, routine, event, my)
  @override
  @TaskCategoryConverter()
  final TaskCategory category;

  /// 색상 값 (예: Colors.blue.value)
  @override
  final int? colorValue;

  /// 추가 메모
  @override
  final String? notes;

  /// 첨부 이미지 목록
  final List<String>? _photoUrls;

  /// 첨부 이미지 목록
  @override
  List<String>? get photoUrls {
    final value = _photoUrls;
    if (value == null) return null;
    if (_photoUrls is EqualUnmodifiableListView) return _photoUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Task(id: $id, title: $title, isCompleted: $isCompleted, date: $date, startTime: $startTime, durationInMinutes: $durationInMinutes, category: $category, colorValue: $colorValue, notes: $notes, photoUrls: $photoUrls)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.durationInMinutes, durationInMinutes) ||
                other.durationInMinutes == durationInMinutes) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.colorValue, colorValue) ||
                other.colorValue == colorValue) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality()
                .equals(other._photoUrls, _photoUrls));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      isCompleted,
      date,
      startTime,
      durationInMinutes,
      category,
      colorValue,
      notes,
      const DeepCollectionEquality().hash(_photoUrls));

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      __$$TaskImplCopyWithImpl<_$TaskImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskImplToJson(
      this,
    );
  }
}

abstract class _Task implements Task {
  const factory _Task(
      {final int? id,
      required final String title,
      final bool isCompleted,
      required final DateTime date,
      @TimeOfDayConverter() final TimeOfDay? startTime,
      final int? durationInMinutes,
      @TaskCategoryConverter() required final TaskCategory category,
      final int? colorValue,
      final String? notes,
      final List<String>? photoUrls}) = _$TaskImpl;

  factory _Task.fromJson(Map<String, dynamic> json) = _$TaskImpl.fromJson;

  /// 고유 ID
  @override
  int? get id;

  /// 할 일 제목
  @override
  String get title;

  /// 완료 여부
  @override
  bool get isCompleted;

  /// 작업 날짜 (YYYY-MM-DD 형태만 사용하거나, DateTime 전체 사용)
  @override
  DateTime get date;

  /// 시작 시간 (필요 시)
  @override
  @TimeOfDayConverter()
  TimeOfDay? get startTime;

  /// 예상 소요 시간(분 단위 등으로 저장해도 됨)
  @override
  int? get durationInMinutes;

  /// 분류(예: todo, routine, event, my)
  @override
  @TaskCategoryConverter()
  TaskCategory get category;

  /// 색상 값 (예: Colors.blue.value)
  @override
  int? get colorValue;

  /// 추가 메모
  @override
  String? get notes;

  /// 첨부 이미지 목록
  @override
  List<String>? get photoUrls;

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
