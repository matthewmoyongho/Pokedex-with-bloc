// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'pokemons_bloc.dart';
// import 'pokemons_event.dart';
// import 'pokemons_state.dart';
//
// class PokemonsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (BuildContext context) => PokemonsBloc()..add(InitEvent()),
//       child: Builder(builder: (context) => _buildPage(context)),
//     );
//   }
//
//   Widget _buildPage(BuildContext context) {
//     final bloc = BlocProvider.of<PokemonsBloc>(context);
//
//     return Container();
//   }
// }
//
