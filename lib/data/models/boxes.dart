import 'package:hive/hive.dart';
import 'package:pokedex/constants.dart';
import 'package:pokedex/data/models/pokemon.dart';

class Boxes {
  static Box<Pokemon> getPokemonBox() => Hive.box<Pokemon>(kFavouritePokemon);
}
