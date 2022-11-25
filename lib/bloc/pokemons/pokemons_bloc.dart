import 'package:bloc/bloc.dart';
import 'package:pokedex/data/repository/pokemon_repository.dart';

import '../../data/models/pokemon.dart';
import 'pokemons_event.dart';
import 'pokemons_state.dart';

class PokemonsBloc extends Bloc<PokemonsEvent, PokemonsState> {
  PokemonsBloc(this.repository) : super(PokemonsState()) {
    on<FetchPokemon>(_init);
  }
  PokemonRepository repository;
  int offset = 0;
  void _init(FetchPokemon event, Emitter<PokemonsState> emit) async {
    if (state is PokemonLoading) return;
    final currentState = state;
    List<Pokemon> oldPokemons = [];
    if (currentState is PokemonLoaded) {
      oldPokemons = currentState.pokemons;
    }
    emit(
      PokemonLoading(oldPokemons, isFirstFetch: offset == 0),
    );

    await repository.getPokemon(offset).then((newPokemons) {
      offset = offset + 21;
      final pokemons = (state as PokemonLoading).pokemons;
      pokemons.addAll(newPokemons);
      print(pokemons.length);
      emit(PokemonLoaded(pokemons));
    });
  }
}
