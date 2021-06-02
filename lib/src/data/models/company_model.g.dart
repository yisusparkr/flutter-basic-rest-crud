// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CompanyModelAdapter extends TypeAdapter<CompanyModel> {
  @override
  final int typeId = 0;

  @override
  CompanyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompanyModel(
      key: fields[0] as int?,
      enterprise: fields[1] as String?,
      number: fields[2] as String?,
      comment: fields[3] as String?,
      date: fields[4] as DateTime?,
      state: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CompanyModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.enterprise)
      ..writeByte(2)
      ..write(obj.number)
      ..writeByte(3)
      ..write(obj.comment)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.state);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompanyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
