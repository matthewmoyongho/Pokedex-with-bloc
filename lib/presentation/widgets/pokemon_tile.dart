import 'package:flutter/material.dart';
import 'package:pokedex/data/models/pokemon.dart';
import 'package:pokedex/presentation/screens/pokemon_details.dart';

class PokemonTile extends StatelessWidget {
  PokemonTile({Key? key, required this.pokemon}) : super(key: key);
  Pokemon pokemon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(PokemonDetail.id, arguments: {'pokemon': pokemon});
      },
      child: Container(
        height: 186,
        width: 110,
        decoration: BoxDecoration(
            color: const Color(0xffFFFFFF),
            borderRadius: BorderRadius.circular(4)),
        child: Column(
          children: [
            Container(
              height: 104,
              width: 110,
              color: const Color(0XFFF3F9EF),
              child: Image(
                image: NetworkImage(
                  pokemon.imageUrl,
                ),
                height: 104,
                width: 104,
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(9),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pokemon.number.length > 1
                        ? '#0${pokemon.number}'
                        : pokemon.number.length > 2
                            ? '#${pokemon.number}'
                            : '#00${pokemon.number}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color(0XFF6B6B6B)),
                  ),
                  Text(
                    pokemon.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0XFF000000)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    pokemon.category,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color(0XFF6B6B6B)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
