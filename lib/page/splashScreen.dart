import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/app_navigator.dart';
import 'package:pokemon/bloc/nav_cubit.dart';
import 'package:pokemon/bloc/pokemon_block.dart';
import 'package:pokemon/bloc/pokemon_details_cubit.dart';
import 'package:pokemon/bloc/pokemon_event.dart';
import 'package:pokemon/page/capturaDatos.dart';
import 'package:pokemon/page/home.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key, this.route});
  final String route;
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final pokemonDetailsCubit = PokemonDetailsCubit();
    return AnimatedSplashScreen(
      splashIconSize: 500,
      splash: 'assets/pokemon.jpg',
      nextScreen: widget.route == "/home"
          ? MultiBlocProvider(providers: [
              BlocProvider(
                  create: (context) =>
                      PokemonBloc()..add(PokemonPageRequest(page: 0))),
              BlocProvider(
                  create: (context) =>
                      NavCubit(pokemonDetailsCubit: pokemonDetailsCubit)),
              BlocProvider(create: (context) => pokemonDetailsCubit)
            ], child: AppNavigator())
          : CapturaDatos(),
      splashTransition: SplashTransition.scaleTransition,
    );
  }
}
