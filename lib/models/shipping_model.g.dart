// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipping_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShippingModelAdapter extends TypeAdapter<ShippingModel> {
  @override
  final int typeId = 1;

  @override
  ShippingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShippingModel(
      fullName: fields[0] as String,
      address: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ShippingModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.fullName)
      ..writeByte(1)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShippingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
