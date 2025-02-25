// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskImpl _$$TaskImplFromJson(Map<String, dynamic> json) => _$TaskImpl(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
      date: DateTime.parse(json['date'] as String),
      startTime: const TimeOfDayConverter()
          .fromJson(json['startTime'] as Map<String, int>?),
      durationInMinutes: (json['durationInMinutes'] as num?)?.toInt(),
      category: $enumDecode(_$TaskCategoryEnumMap, json['category']),
      colorValue: (json['colorValue'] as num?)?.toInt(),
      notes: json['notes'] as String?,
      photoUrls: (json['photoUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'isCompleted': instance.isCompleted,
      'date': instance.date.toIso8601String(),
      'startTime': const TimeOfDayConverter().toJson(instance.startTime),
      'durationInMinutes': instance.durationInMinutes,
      'category': _$TaskCategoryEnumMap[instance.category]!,
      'colorValue': instance.colorValue,
      'notes': instance.notes,
      'photoUrls': instance.photoUrls,
    };

const _$TaskCategoryEnumMap = {
  TaskCategory.todo: 'todo',
  TaskCategory.routine: 'routine',
  TaskCategory.event: 'event',
  TaskCategory.my: 'my',
};
