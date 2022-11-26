import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/data/repository/pokemon_repository.dart';
import 'package:pokedex/presentation/screens/pokemon_details.dart';

import './screens/home.dart';
import '../bloc/pokemons/pokemons_bloc.dart';

class App extends StatelessWidget {
  PokemonRepository repository;
  App({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokemonsBloc(repository),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            tabBarTheme: TabBarTheme(
              labelColor: Color(0xff161A33),
              labelStyle: GoogleFonts.notoSans(
                textStyle: TextStyle(fontSize: 16),
              ),
              unselectedLabelColor: Color(0xff161A33),
              unselectedLabelStyle: GoogleFonts.notoSans(
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
            textTheme: TextTheme(bodyText2: GoogleFonts.notoSans()),
            appBarTheme: const AppBarTheme(
                backgroundColor: Color(0XFFFFFFFF), elevation: 1)),
        home: Home(),
        routes: {
          // '/': (context) => Home(),
          PokemonDetail.id: (context) => PokemonDetail()
        },
      ),
    );
  }
}
