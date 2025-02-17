// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TodoItem _$TodoItemFromJson(Map<String, dynamic> json) {
  return _TodoItem.fromJson(json);
}

/// @nodoc
mixin _$TodoItem {
  /// Supabase에서 자동 생성하는 id (없을 수 있으므로 nullable)
  int? get id => throw _privateConstructorUsedError;

  /// 하루 종일 여부
  bool get isAllDay => throw _privateConstructorUsedError;

  /// 시작 날짜 (년.월.일)
  DateTime get startDate => throw _privateConstructorUsedError;

  /// 종료 날짜 (년.월.일)
  DateTime get endDate => throw _privateConstructorUsedError;

  /// 항목 제목
  String get title => throw _privateConstructorUsedError;

  /// 설명 텍스트
  String get description => throw _privateConstructorUsedError;

  /// 색상 값 (예, Colors.blue.value)
  int get color => throw _privateConstructorUsedError;

  /// 사진 첨부 URL 목록 (여러 장의 사진 첨부 가능)
  List<String>? get photoUrls => throw _privateConstructorUsedError;

  /// Serializes this TodoItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TodoItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TodoItemCopyWith<TodoItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoItemCopyWith<$Res> {
  factory $TodoItemCopyWith(TodoItem value, $Res Function(TodoItem) then) =
      _$TodoItemCopyWithImpl<$Res, TodoItem>;
  @useResult
  $Res call(
      {int? id,
      bool isAllDay,
      DateTime startDate,
      DateTime endDate,
      String title,
      String description,
      int color,
      List<String>? photoUrls});
}

/// @nodoc
class _$TodoItemCopyWithImpl<$Res, $Val extends TodoItem>
    implements $TodoItemCopyWith<$Res> {
  _$TodoItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TodoItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? isAllDay = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? title = null,
    Object? description = null,
    Object? color = null,
    Object? photoUrls = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      isAllDay: null == isAllDay
          ? _value.isAllDay
          : isAllDay // ignore: cast_nullable_to_non_nullable
              as bool,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int,
      photoUrls: freezed == photoUrls
          ? _value.photoUrls
          : photoUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TodoItemImplCopyWith<$Res>
    implements $TodoItemCopyWith<$Res> {
  factory _$$TodoItemImplCopyWith(
          _$TodoItemImpl value, $Res Function(_$TodoItemImpl) then) =
      __$$TodoItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      bool isAllDay,
      DateTime startDate,
      DateTime endDate,
      String title,
      String description,
      int color,
      List<String>? photoUrls});
}

/// @nodoc
class __$$TodoItemImplCopyWithImpl<$Res>
    extends _$TodoItemCopyWithImpl<$Res, _$TodoItemImpl>
    implements _$$TodoItemImplCopyWith<$Res> {
  __$$TodoItemImplCopyWithImpl(
      _$TodoItemImpl _value, $Res Function(_$TodoItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of TodoItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? isAllDay = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? title = null,
    Object? description = null,
    Object? color = null,
    Object? photoUrls = freezed,
  }) {
    return _then(_$TodoItemImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      isAllDay: null == isAllDay
          ? _value.isAllDay
          : isAllDay // ignore: cast_nullable_to_non_nullable
              as bool,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int,
      photoUrls: freezed == photoUrls
          ? _value._photoUrls
          : photoUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$TodoItemImpl implements _TodoItem {
  _$TodoItemImpl(
      {this.id,
      required this.isAllDay,
      required this.startDate,
      required this.endDate,
      required this.title,
      required this.description,
      required this.color,
      final List<String>? photoUrls})
      : _photoUrls = photoUrls;

  factory _$TodoItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$TodoItemImplFromJson(json);

  /// Supabase에서 자동 생성하는 id (없을 수 있으므로 nullable)
  @override
  final int? id;

  /// 하루 종일 여부
  @override
  final bool isAllDay;

  /// 시작 날짜 (년.월.일)
  @override
  final DateTime startDate;

  /// 종료 날짜 (년.월.일)
  @override
  final DateTime endDate;

  /// 항목 제목
  @override
  final String title;

  /// 설명 텍스트
  @override
  final String description;

  /// 색상 값 (예, Colors.blue.value)
  @override
  final int color;

  /// 사진 첨부 URL 목록 (여러 장의 사진 첨부 가능)
  final List<String>? _photoUrls;

  /// 사진 첨부 URL 목록 (여러 장의 사진 첨부 가능)
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
    return 'TodoItem(id: $id, isAllDay: $isAllDay, startDate: $startDate, endDate: $endDate, title: $title, description: $description, color: $color, photoUrls: $photoUrls)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.isAllDay, isAllDay) ||
                other.isAllDay == isAllDay) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.color, color) || other.color == color) &&
            const DeepCollectionEquality()
                .equals(other._photoUrls, _photoUrls));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      isAllDay,
      startDate,
      endDate,
      title,
      description,
      color,
      const DeepCollectionEquality().hash(_photoUrls));

  /// Create a copy of TodoItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoItemImplCopyWith<_$TodoItemImpl> get copyWith =>
      __$$TodoItemImplCopyWithImpl<_$TodoItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TodoItemImplToJson(
      this,
    );
  }
}

abstract class _TodoItem implements TodoItem {
  factory _TodoItem(
      {final int? id,
      required final bool isAllDay,
      required final DateTime startDate,
      required final DateTime endDate,
      required final String title,
      required final String description,
      required final int color,
      final List<String>? photoUrls}) = _$TodoItemImpl;

  factory _TodoItem.fromJson(Map<String, dynamic> json) =
      _$TodoItemImpl.fromJson;

  /// Supabase에서 자동 생성하는 id (없을 수 있으므로 nullable)
  @override
  int? get id;

  /// 하루 종일 여부
  @override
  bool get isAllDay;

  /// 시작 날짜 (년.월.일)
  @override
  DateTime get startDate;

  /// 종료 날짜 (년.월.일)
  @override
  DateTime get endDate;

  /// 항목 제목
  @override
  String get title;

  /// 설명 텍스트
  @override
  String get description;

  /// 색상 값 (예, Colors.blue.value)
  @override
  int get color;

  /// 사진 첨부 URL 목록 (여러 장의 사진 첨부 가능)
  @override
  List<String>? get photoUrls;

  /// Create a copy of TodoItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TodoItemImplCopyWith<_$TodoItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
