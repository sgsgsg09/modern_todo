import 'package:hive/hive.dart';
import 'package:modern_todo/models/todo_item.dart';

class TodoItemHiveAdapter extends TypeAdapter<TodoItem> {
  @override
  final int typeId = 0; // 앱 내에서 유일한 타입 ID

  @override
  TodoItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{};
    for (int i = 0; i < numOfFields; i++) {
      final key = reader.readByte();
      final value = reader.read();
      fields[key] = value;
    }
    return TodoItem(
      id: fields[0] as int?,
      isAllDay: fields[1] as bool,
      startDate: DateTime.parse(fields[2] as String),
      endDate: DateTime.parse(fields[3] as String),
      title: fields[4] as String,
      description: fields[5] as String,
      color: fields[6] as int,
      photoUrls: (fields[7] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, TodoItem obj) {
    writer
      ..writeByte(8) // 필드 개수
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.isAllDay)
      ..writeByte(2)
      ..write(obj.startDate.toIso8601String())
      ..writeByte(3)
      ..write(obj.endDate.toIso8601String())
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.color)
      ..writeByte(7)
      ..write(obj.photoUrls);
  }
}
