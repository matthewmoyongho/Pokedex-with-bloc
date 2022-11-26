// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonAdapter extends TypeAdapter<Pokemon> {
  @override
  final int typeId = 0;

  @override
  Pokemon read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pokemon(
      id: fields[0] as int?,
      speed: fields[13] as int,
      imageUrl: fields[5] as String,
      number: fields[1] as String,
      name: fields[2] as String,
      category: fields[3] as String,
      isFavourite: fields[4] as bool,
      height: fields[6] as int,
      attack: fields[9] as int,
      defence: fields[10] as int,
      hp: fields[8] as int,
      specialAttack: fields[11] as int,
      specialDefence: fields[12] as int,
      weight: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Pokemon obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.number)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.isFavourite)
      ..writeByte(5)
      ..write(obj.imageUrl)
      ..writeByte(6)
      ..write(obj.height)
      ..writeByte(7)
      ..write(obj.weight)
      ..writeByte(8)
      ..write(obj.hp)
      ..writeByte(9)
      ..write(obj.attack)
      ..writeByte(10)
      ..write(obj.defence)
      ..writeByte(11)
      ..write(obj.specialAttack)
      ..writeByte(12)
      ..write(obj.specialDefence)
      ..writeByte(13)
      ..write(obj.speed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
