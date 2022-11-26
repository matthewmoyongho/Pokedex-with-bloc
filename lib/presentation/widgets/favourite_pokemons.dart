import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pokedex/presentation/widgets/pokemon_tile.dart';

import '../../bloc/pokemons/pokemons_bloc.dart';
import '../../bloc/pokemons/pokemons_state.dart';
import '../../data/models/boxes.dart';
import '../../data/models/pokemon.dart';

class FavouritePokemons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonsBloc, PokemonsState>(
      builder: (context, state) {
        return ValueListenableBuilder<Box<Pokemon>>(
          valueListenable: Boxes.getPokemonBox().listenable(),
          builder: (context, box, _) {
            final pokemons = box.values.toList().cast<Pokemon>();
            if (pokemons.isEmpty) {
              return const Center(
                child: Text('No favourite added yet!'),
              );
            }
            return GridView.builder(
              itemCount: pokemons.length,
              itemBuilder: (context, index) {
                return PokemonTile(
                  pokemon: pokemons[index],
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 186,
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 12),
              padding: const EdgeInsets.all(15),
              // child: Center(
              //   child: Text('All Pokemons goes here'),
              // ),
            );
          },
        );
      },
    );
  }
}
