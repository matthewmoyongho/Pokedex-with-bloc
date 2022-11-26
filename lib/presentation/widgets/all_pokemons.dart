import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/pokemons/pokemons_event.dart';
import 'package:pokedex/presentation/widgets/pokemon_tile.dart';

import '../../bloc/pokemons/pokemons_bloc.dart';
import '../../bloc/pokemons/pokemons_state.dart';

class AllPokemons extends StatelessWidget {
  AllPokemons({Key? key}) : super(key: key);

  final scrollController = ScrollController();

  void setupScrollControl(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<PokemonsBloc>(context).add(FetchPokemon());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollControl(context);
    return BlocBuilder<PokemonsBloc, PokemonsState>(
      builder: (context, state) {
        if (state is PokemonLoading && state.isFirstFetch == true) {
          return _loadingIndicator();
        }
        List pokemons = [];
        bool loading = false;
        if (state is PokemonLoading) {
          loading = true;
          pokemons = state.pokemons;
        } else if (state is PokemonLoaded) {
          pokemons = state.pokemons;
        }
        if (pokemons.isEmpty) {
          return Center(
            child: Text('List is empty'),
          );
        }
        return GridView.builder(
          controller: scrollController,
          itemCount: pokemons.length + (loading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < pokemons.length) {
              return PokemonTile(
                pokemon: state.pokemons[index],
              );
            } else {
              Timer(Duration(milliseconds: 300), () {
                scrollController
                    .jumpTo(scrollController.position.maxScrollExtent);
              });
              return _loadingIndicator();
            }
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
  }
}

Widget _loadingIndicator() {
  return Container(
    padding: const EdgeInsets.all(15),
    width: double.infinity,
    child: const Center(
      child: CircularProgressIndicator(),
    ),
  );
}
