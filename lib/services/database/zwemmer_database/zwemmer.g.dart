// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zwemmer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ZwemmerDataAdapter extends TypeAdapter<ZwemmerData> {
  @override
  final int typeId = 1;

  @override
  ZwemmerData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ZwemmerData(
      id: fields[1] as String,
      opmerking: fields[6] as String,
      naam: fields[0] as String,
      groep: fields[2] as String,
      isAanwezig: fields[7] as bool,
      isSelected: fields[8] as bool,
      niveauId: fields[5] as String,
      statusOef1: fields[3] as bool,
      statusOef2: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ZwemmerData obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.naam)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.groep)
      ..writeByte(3)
      ..write(obj.statusOef1)
      ..writeByte(4)
      ..write(obj.statusOef2)
      ..writeByte(5)
      ..write(obj.niveauId)
      ..writeByte(6)
      ..write(obj.opmerking)
      ..writeByte(7)
      ..write(obj.isAanwezig)
      ..writeByte(8)
      ..write(obj.isSelected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZwemmerDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
