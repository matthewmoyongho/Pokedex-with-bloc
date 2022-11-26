import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/constants.dart';
import 'package:pokedex/data/models/pokemon.dart';
import 'package:pokedex/data/repository/pokemon_repository.dart';
import 'package:pokedex/data/services/pokemon_service.dart';

import './presentation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(PokemonAdapter());
  await Hive.openBox<Pokemon>(kFavouritePokemon);

  runApp(App(
    repository: PokemonRepository(PokemonService()),
  ));
}
