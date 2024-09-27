// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistoryModelAdapter extends TypeAdapter<HistoryModel> {
  @override
  final int typeId = 11;

  @override
  HistoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HistoryModel()
      ..time = fields[0] as String
      ..duration = fields[1] as String
      ..name1 = fields[2] as String
      ..description1 = fields[3] as String
      ..status1 = fields[4] as String
      ..name2 = fields[5] as String
      ..description2 = fields[6] as String
      ..status2 = fields[7] as String
      ..name3 = fields[8] as String
      ..description3 = fields[9] as String
      ..status3 = fields[10] as String;
  }

  @override
  void write(BinaryWriter writer, HistoryModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.time)
      ..writeByte(1)
      ..write(obj.duration)
      ..writeByte(2)
      ..write(obj.name1)
      ..writeByte(3)
      ..write(obj.description1)
      ..writeByte(4)
      ..write(obj.status1)
      ..writeByte(5)
      ..write(obj.name2)
      ..writeByte(6)
      ..write(obj.description2)
      ..writeByte(7)
      ..write(obj.status2)
      ..writeByte(8)
      ..write(obj.name3)
      ..writeByte(9)
      ..write(obj.description3)
      ..writeByte(10)
      ..write(obj.status3);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
