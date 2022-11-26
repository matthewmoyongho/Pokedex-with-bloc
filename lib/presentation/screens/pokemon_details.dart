import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/data/models/boxes.dart';
import 'package:pokedex/data/models/pokemon.dart';

import '../../bloc/pokemons/pokemons_bloc.dart';
import '../../bloc/pokemons/pokemons_event.dart';
import '../../bloc/pokemons/pokemons_state.dart';

class PokemonDetail extends StatefulWidget {
  static const String id = 'pokemonDetail';

  @override
  State<PokemonDetail> createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  @override
  Widget build(BuildContext context) {
    final box = Boxes.getPokemonBox();
    final deviceSize = MediaQuery.of(context).size;
    final loadedPokemon =
        ModalRoute.of(context)!.settings.arguments as Map<String, Pokemon>;

    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(Icons.arrow_back_ios_outlined)),
          iconTheme: const IconThemeData(
            color: Colors.black,
          )),
      body: BlocBuilder<PokemonsBloc, PokemonsState>(
        builder: (context, state) {
          if (state is PokemonLoaded) {
            final pokemon = box.get(loadedPokemon['pokemon']!.id) ??
                state.pokemons.firstWhere((pokemon) =>
                    pokemon.number == loadedPokemon['pokemon']!.number);

            return Column(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Color(0XFFF3F9EF)),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 23,
                        left: 16,
                        child: Text(
                          pokemon.name,
                          style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: Color(0XFF161A33)),
                        ),
                      ),
                      Positioned(
                        top: 67,
                        left: 16,
                        child: Text(
                          pokemon.category,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0XFF161A33)),
                        ),
                      ),
                      Positioned(
                        bottom: 14,
                        left: 16,
                        child: Text(
                          pokemon.number.length > 1
                              ? '#0${pokemon.number}'
                              : pokemon.number.length > 2
                                  ? '#${pokemon.number}'
                                  : '#00${pokemon.number}',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0XFF161A33)),
                        ),
                      ),
                      const Positioned(
                        bottom: -10,
                        right: -23,
                        child: Image(
                          image: AssetImage('assets/images/Vector.png'),
                          height: 176,
                          width: 176,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 16,
                        child: Image(
                          image: NetworkImage(pokemon.imageUrl),
                          height: 125,
                          width: 136,
                        ),
                      ),
                    ],
                  ),
                ),
                MassIndex(pokemon: pokemon),
                const SizedBox(
                  height: 8,
                ),
                BaseStats(pokemon: pokemon, deviceSize: deviceSize)
              ],
            );
          }
          return const Center(
            child: Text('Unable to load pokemon'),
          );
        },
      ),
      floatingActionButton:
          BlocBuilder<PokemonsBloc, PokemonsState>(builder: (context, state) {
        final box = Boxes.getPokemonBox();
        Pokemon? pokemon;
        if (state is PokemonLoaded) {
          pokemon = box.get(loadedPokemon['pokemon']!.id) ??
              state.pokemons.firstWhere((pokemon) =>
                  pokemon.number == loadedPokemon['pokemon']!.number);
        }
        return FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              BlocProvider.of<PokemonsBloc>(context)
                  .add(SwitchPokemonFavourite(pokemon!));
            });
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
          label: Text(
            pokemon!.isFavourite
                ? 'Remove from favourites'
                : 'Add to favourites',
            style: TextStyle(
                color: pokemon.isFavourite
                    ? const Color(0XFF3558CD)
                    : const Color(0XFFFFFFFF)),
          ),
          backgroundColor: pokemon.isFavourite
              ? const Color(0XFFD5DEFF)
              : const Color(0XFF3558CD),
        );
      }),
    );
  }
}

class BaseStats extends StatelessWidget {
  const BaseStats({
    Key? key,
    required this.pokemon,
    required this.deviceSize,
  }) : super(key: key);

  final Pokemon pokemon;
  final Size deviceSize;

  @override
  Widget build(BuildContext context) {
    final avgPower = (pokemon.speed +
            pokemon.specialDefence +
            pokemon.specialAttack +
            pokemon.attack +
            pokemon.defence +
            pokemon.hp) /
        6.round();
    return Expanded(
      child: Container(
        color: const Color(0XFFFFFFFF),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 46,
                child: const Text(
                  'Base stats',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const Divider(
                color: Color(0XFFE8E8E8),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hp ${pokemon.hp}',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: double.infinity,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0XFFE8E8E8),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            width: ((pokemon.hp / 100) * deviceSize.width),
                            height: 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: pokemon.hp >= 50
                                  ? Colors.green
                                  : pokemon.hp >= 45
                                      ? Colors.yellow
                                      : pokemon.hp >= 31
                                          ? Colors.orange
                                          : Colors.red,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Attack ${pokemon.attack}',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: double.infinity,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0XFFE8E8E8),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            width: ((pokemon.attack / 100) * deviceSize.width),
                            height: 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: pokemon.attack >= 50
                                  ? Colors.green
                                  : pokemon.attack >= 45
                                      ? Colors.yellow
                                      : pokemon.attack >= 31
                                          ? Colors.orange
                                          : Colors.red,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Defence ${pokemon.defence}',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: double.infinity,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0XFFE8E8E8),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            width: ((pokemon.defence / 100) * deviceSize.width),
                            height: 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: pokemon.defence >= 50
                                  ? Colors.green
                                  : pokemon.defence >= 45
                                      ? Colors.yellow
                                      : pokemon.defence >= 31
                                          ? Colors.orange
                                          : Colors.red,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Special Attack ${pokemon.specialAttack}',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: double.infinity,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0XFFE8E8E8),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            width: ((pokemon.specialAttack / 100) *
                                deviceSize.width),
                            height: 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: pokemon.specialAttack >= 50
                                  ? Colors.green
                                  : pokemon.specialAttack >= 45
                                      ? Colors.yellow
                                      : pokemon.specialAttack >= 31
                                          ? Colors.orange
                                          : Colors.red,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Special Defence ${pokemon.specialDefence}',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: double.infinity,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0XFFE8E8E8),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            width: ((pokemon.specialDefence / 100) *
                                deviceSize.width),
                            height: 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: pokemon.specialDefence >= 50
                                  ? Colors.green
                                  : pokemon.specialDefence >= 45
                                      ? Colors.yellow
                                      : pokemon.specialDefence >= 31
                                          ? Colors.orange
                                          : Colors.red,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Speed ${pokemon.speed}',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: double.infinity,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0XFFE8E8E8),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            width: ((pokemon.speed / 100) * deviceSize.width),
                            height: 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: pokemon.speed >= 50
                                  ? Colors.green
                                  : pokemon.speed >= 45
                                      ? Colors.yellow
                                      : pokemon.speed >= 31
                                          ? Colors.orange
                                          : Colors.red,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Avg. Power $avgPower',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: double.infinity,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0XFFE8E8E8),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            width: ((avgPower / 100) * deviceSize.width),
                            height: 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: avgPower >= 50
                                  ? Colors.green
                                  : avgPower >= 45
                                      ? Colors.yellow
                                      : avgPower >= 31
                                          ? Colors.orange
                                          : Colors.red,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MassIndex extends StatelessWidget {
  const MassIndex({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78,
      color: const Color(0XFFFFFFFF),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Height'),
              Text(
                pokemon.height.toString(),
              ),
            ],
          ),
          const SizedBox(
            width: 48,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Weight'),
              Text(
                pokemon.weight.toString(),
              ),
            ],
          ),
          const SizedBox(
            width: 48,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('BMI'),
              Text(
                (pokemon.weight / (pokemon.height * pokemon.height))
                    .toStringAsFixed(2),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
