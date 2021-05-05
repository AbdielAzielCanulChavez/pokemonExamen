import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/page/detallehome.dart';
import 'package:pokemon/page/equiposPage.dart';
import 'package:pokemon/page/home.dart';

import 'bloc/nav_cubit.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavCubit, int>(builder: (context, pokemonId) {
      return Navigator(
        pages: [
          MaterialPage(child: HomePage()),
          if (pokemonId != null) MaterialPage(child: PokemonDetailsView()),
          if (banderaDe != true) MaterialPage(child: EquiposPokemon())
        ],
        onPopPage: (route, result) {
          BlocProvider.of<NavCubit>(context).popToPokedex();
          return route.didPop(result);
        },
      );
    });
  }
}
