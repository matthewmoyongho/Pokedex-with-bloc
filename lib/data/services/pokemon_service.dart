import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/pokemon.dart';

class PokemonService {
  static const FETCH_LIMIT = 21;
  String baseurl = 'https://pokeapi.co/api/v2/pokemon?';

  // https://pokeapi.co/api/v2/pokemon?offset=0&limit=20

  Future<List<dynamic>> getPokemons(int offset) async {
    print('this is get services');
    try {
      final respond = await http.get(Uri.parse(
          'https://pokeapi.co/api/v2/pokemon?offset=$offset&limit=$FETCH_LIMIT'));

      print('getting');
      final pokemonsUrl = jsonDecode(respond.body) as Map;
      final pokeUrls = pokemonsUrl['results'] as List;

      pokeUrls.forEach((poke) {
        print(poke['url']);
      });

      print('this line ran');
      List<Pokemon> pokes = [];
      for (var pokemon in pokeUrls) {
        String pokeUlr = pokemon['url'];
        try {
          http.Response res = await http.get(Uri.parse(pokeUlr));
          final resBody = await jsonDecode(res.body);

          Pokemon pokemonDetail = Pokemon(
            imageUrl: resBody['sprites']['other']['official-artwork']
                ['front_default'],
            number: resBody['id'].toString(),
            name: resBody['name'],
            category: resBody['types'][0]['type']['name'],
            height: resBody['height'],
            attack: resBody['stats'][1]['base_stat'],
            defence: resBody['stats'][2]['base_stat'],
            hp: resBody['stats'][0]['base_stat'],
            specialAttack: resBody['stats'][3]['base_stat'],
            specialDefence: resBody['stats'][4]['base_stat'],
            weight: resBody['weight'],
            speed: resBody['stats'][5]['base_stat'],
          );
          print(pokemonDetail.height);
          pokes.add(pokemonDetail);
        } catch (err) {
          rethrow;
        }
      }

      if (pokes.isEmpty) print('I am empty');
      print(pokes.length);
      return pokes;
    } catch (err) {
      return [];
    }
  }
}
