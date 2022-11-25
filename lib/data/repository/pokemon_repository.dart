import 'package:pokedex/data/models/pokemon.dart';
import 'package:pokedex/data/services/pokemon_service.dart';

class PokemonRepository {
  PokemonService service;
  PokemonRepository(this.service);
  Future<List<Pokemon>> getPokemon(int offset) async {
    final fetchedPokemon = await service.getPokemons(offset);
    List<Pokemon> pokemons = [];
    for (var pokemon in fetchedPokemon) {
      pokemons.add(pokemon);
    }
    print('I am in the repository');
    print(pokemons.length);
    return pokemons;
  }
}
