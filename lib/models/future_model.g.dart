// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'future_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FutureModelAdapter extends TypeAdapter<FutureModel> {
  @override
  final int typeId = 9;

  @override
  FutureModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FutureModel()
      ..name = fields[0] as String
      ..description = fields[1] as String
      ..deadline = fields[2] as String
      ..time = fields[3] as String
      ..status = fields[4] as String
      ..daniel = fields[5] as bool
      ..leonard = fields[6] as bool;
  }

  @override
  void write(BinaryWriter writer, FutureModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.deadline)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.daniel)
      ..writeByte(6)
      ..write(obj.leonard);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FutureModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
