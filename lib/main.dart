import 'package:flutter/material.dart';
import 'package:pokedex/data/repository/pokemon_repository.dart';
import 'package:pokedex/data/services/pokemon_service.dart';

import './presentation/app.dart';

void main() {
  runApp(App(
    repository: PokemonRepository(PokemonService()),
  ));
}
