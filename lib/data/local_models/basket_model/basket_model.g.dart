// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BasketLocalModelAdapter extends TypeAdapter<BasketLocalModel> {
  @override
  final int typeId = 2;

  @override
  BasketLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BasketLocalModel(
      id: fields[0] as int,
      name: fields[1] as String?,
      price: fields[2] as double?,
      image: fields[3] as String?,
      count: fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, BasketLocalModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.count);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BasketLocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
