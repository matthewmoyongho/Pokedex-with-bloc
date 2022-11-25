import 'package:equatable/equatable.dart';
import 'package:pokedex/data/models/pokemon.dart';

class PokemonsState extends Equatable {
  final List<Pokemon> pokemons;
  PokemonsState({this.pokemons = const []});

  @override
  List<Object?> get props => [pokemons];
}

class PokemonLoaded extends PokemonsState {
  final List<Pokemon> pokemons;
  PokemonLoaded(this.pokemons);
}

class PokemonLoading extends PokemonsState {
  final List<Pokemon> pokemons;
  bool isFirstFetch;
  PokemonLoading(this.pokemons, {this.isFirstFetch = false});
}
