// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_history_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitHistoryModelAdapter extends TypeAdapter<HabitHistoryModel> {
  @override
  final int typeId = 23;

  @override
  HabitHistoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HabitHistoryModel()
      ..name = fields[0] as String
      ..startTime = fields[1] as String
      ..endTime = fields[2] as String
      ..totalDays = fields[3] as String
      ..goodDays = fields[4] as String
      ..badDays = fields[5] as String;
  }

  @override
  void write(BinaryWriter writer, HabitHistoryModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.startTime)
      ..writeByte(2)
      ..write(obj.endTime)
      ..writeByte(3)
      ..write(obj.totalDays)
      ..writeByte(4)
      ..write(obj.goodDays)
      ..writeByte(5)
      ..write(obj.badDays);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitHistoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
