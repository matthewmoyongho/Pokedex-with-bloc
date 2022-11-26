import 'package:bloc/bloc.dart';
import 'package:pokedex/data/models/boxes.dart';
import 'package:pokedex/data/repository/pokemon_repository.dart';

import '../../data/models/pokemon.dart';
import 'pokemons_event.dart';
import 'pokemons_state.dart';

class PokemonsBloc extends Bloc<PokemonsEvent, PokemonsState> {
  PokemonsBloc(this.repository) : super(PokemonsState()) {
    on<FetchPokemon>(_fetchAllPokemon);
    on<SwitchPokemonFavourite>(_switchFavourite);
    //on<FetchPokemonFromLocalStorage>(_fetchPokemonFromLocalStorage);
  }
  PokemonRepository repository;
  int offset = 0;
  void _fetchAllPokemon(FetchPokemon event, Emitter<PokemonsState> emit) async {
    if (state is PokemonLoading) return;
    final currentState = state;
    List<Pokemon> oldPokemons = [];
    final box = Boxes.getPokemonBox();
    if (currentState is PokemonLoaded) {
      oldPokemons = currentState.pokemons;
    }
    emit(
      PokemonLoading(
        pokemons: oldPokemons,
        isFirstFetch: offset == 0,
      ),
    );

    await repository.getPokemon(offset).then((newPokemons) {
      offset = offset + 21;
      final pokemons = (state as PokemonLoading).pokemons;
      pokemons.addAll(newPokemons);
      print(pokemons.length);
      emit(
        PokemonLoaded(
          pokemons: pokemons,
        ),
      );
    });
  }

  void _switchFavourite(
      SwitchPokemonFavourite event, Emitter<PokemonsState> emit) async {
    final box = Boxes.getPokemonBox();

    if (!event.pokemon.isFavourite) {
      event.pokemon.isFavourite = true;
      event.pokemon.id = int.parse(event.pokemon.number);
      await box.put(event.pokemon.id, event.pokemon);
    } else if (event.pokemon.isFavourite) {
      event.pokemon.isFavourite = false;
      await box.delete(event.pokemon.id);
    }
  }

  // void _fetchPokemonFromLocalStorage(
  //     FetchPokemonFromLocalStorage event, Emitter<PokemonsState> emit) async {
  //   final pokemon = event.pokemon;
  //   final loadedPokemon;
  //   final box = Boxes.getPokemonBox();
  //   if (pokemon.id != null) {
  //     loadedPokemon = box.get(pokemon.id, defaultValue: pokemon);
  //   } else {
  //     loadedPokemon = pokemon;
  //   }
  //
  //   emit(
  //     PokemonLoaded(
  //       pokemons: (state as PokemonLoaded).pokemons,
  //       loadedPokemon: loadedPokemon,
  //     ),
  //   );
  // }
}
