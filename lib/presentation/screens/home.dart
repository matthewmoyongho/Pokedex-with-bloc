import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/bloc/pokemons/pokemons_bloc.dart';
import 'package:pokedex/bloc/pokemons/pokemons_event.dart';
import 'package:pokedex/presentation/widgets/all_pokemons.dart';
import 'package:pokedex/presentation/widgets/favourite_pokemons.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    BlocProvider.of<PokemonsBloc>(context).add(FetchPokemon());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Image(
              height: 24,
              width: 24,
              image: AssetImage('assets/images/logo_icon.png'),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              'Pokedex',
              style: GoogleFonts.notoSans(
                textStyle: const TextStyle(
                    color: Color(0xff161A33),
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          TabBar(
            controller: tabController,
            tabs: const [
              Tab(
                text: 'All Pokemons',
              ),
              Tab(
                text: 'Favourites',
              ),
            ],
          ),
          Expanded(
              child: TabBarView(
            controller: tabController,
            children: [
              AllPokemons(),
              FavouritePokemons(),
            ],
          ))
        ],
      ),
    );
  }
}
