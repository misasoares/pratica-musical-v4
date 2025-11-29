// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'practice_log_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PracticeLogModelAdapter extends TypeAdapter<PracticeLogModel> {
  @override
  final int typeId = 1;

  @override
  PracticeLogModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PracticeLogModel(
      id: fields[0] as String,
      exerciseId: fields[1] as String,
      date: fields[2] as DateTime,
      mode: fields[3] as String,
      maxBpmReached: fields[4] as int,
      durationSeconds: fields[5] as int,
      result: fields[6] as String,
      targetBpm: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PracticeLogModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.exerciseId)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.mode)
      ..writeByte(4)
      ..write(obj.maxBpmReached)
      ..writeByte(5)
      ..write(obj.durationSeconds)
      ..writeByte(6)
      ..write(obj.result)
      ..writeByte(7)
      ..write(obj.targetBpm);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PracticeLogModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
