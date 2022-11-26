import 'package:equatable/equatable.dart';
import 'package:pokedex/data/models/pokemon.dart';

abstract class PokemonsEvent extends Equatable {}

class FetchPokemon extends PokemonsEvent {
  @override
  List<Object?> get props => [];
}

class SwitchPokemonFavourite extends PokemonsEvent {
  final Pokemon pokemon;
  SwitchPokemonFavourite(this.pokemon);
  @override
  List<Object?> get props => [pokemon];
}
