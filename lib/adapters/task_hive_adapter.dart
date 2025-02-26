import 'package:hive/hive.dart';
import 'package:modern_todo/models/task.dart';
import 'package:flutter/material.dart';
import 'package:modern_todo/models/task_category.dart';

class TaskHiveAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 0; // 앱 내에서 유일한 타입 ID

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{};
    for (int i = 0; i < numOfFields; i++) {
      final key = reader.readByte();
      final value = reader.read();
      fields[key] = value;
    }
    return Task(
      id: fields[0] as int?,
      title: fields[1] as String,
      isCompleted: fields[2] as bool,
      date: DateTime.parse(fields[3] as String),
      startTime: fields[4] == null
          ? null
          : TimeOfDay(
              hour: (fields[4] as Map)['hour'] as int,
              minute: (fields[4] as Map)['minute'] as int,
            ),
      durationInMinutes: fields[5] as int?,
      category: fields[6] as TaskCategory, // 수정: TaskCategory 객체 자체를 읽어옴.
      colorValue: fields[7] as int?,
      notes: fields[8] as String?,
      photoUrls: (fields[9] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(10) // 총 10개의 필드 저장
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.isCompleted)
      ..writeByte(3)
      ..write(obj.date.toIso8601String())
      ..writeByte(4)
      ..write(obj.startTime == null
          ? null
          : {'hour': obj.startTime!.hour, 'minute': obj.startTime!.minute})
      ..writeByte(5)
      ..write(obj.durationInMinutes)
      ..writeByte(6)
      ..write(obj.category) // 수정: TaskCategory 객체 자체를 저장.
      ..writeByte(7)
      ..write(obj.colorValue)
      ..writeByte(8)
      ..write(obj.notes)
      ..writeByte(9)
      ..write(obj.photoUrls);
  }
}
