import 'package:equatable/equatable.dart';
import 'package:pokedex/data/models/pokemon.dart';

class PokemonsState extends Equatable {
  final List<Pokemon> pokemons;
  final List<Pokemon> favouritePokemons;
  PokemonsState({this.pokemons = const [], this.favouritePokemons = const []});

  @override
  List<Object?> get props => [pokemons];
}

class PokemonLoaded extends PokemonsState {
  final List<Pokemon> pokemons;

  final Pokemon? loadedPokemon;
  PokemonLoaded({required this.pokemons, this.loadedPokemon});
}

class PokemonLoading extends PokemonsState {
  final List<Pokemon> pokemons;
  bool isFirstFetch;
  PokemonLoading({
    required this.pokemons,
    this.isFirstFetch = false,
  });
}
