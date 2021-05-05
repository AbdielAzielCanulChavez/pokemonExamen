import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pokemon/bloc/nav_cubit.dart';
import 'package:pokemon/bloc/pokemon_block.dart';
import 'package:pokemon/bloc/pokemon_details_cubit.dart';
import 'package:pokemon/bloc/pokemon_event.dart';

import 'package:pokemon/bloc/pokemon_state.dart';

import 'dart:math' as math;

import 'package:pokemon/preferencias/variablesglobales.dart';

import '../app_navigator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List colors = [
    Colors.redAccent,
    Colors.yellow,
    Colors.yellowAccent,
    Colors.pink,
    Colors.pinkAccent
  ];
  Random random = new Random();

  int index = 0;

  void changeIndex() {
    setState(() {
      index = random.nextInt(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          FontAwesomeIcons.longArrowAltLeft,
          color: Colors.black,
        ),
        actions: [
          IconButton(
              icon: Icon(
                FontAwesomeIcons.bars,
                color: Colors.black,
              ),
              onPressed: () {
                print('menu');
              })
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [],
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: prefs.nombreUsuario != null &&
                              prefs.nombreUsuario.toString() != ""
                          ? Text(
                              "POKEDEX de " + prefs.nombreUsuario,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900),
                            )
                          : Text(
                              "POKEDEX",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900),
                            ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<PokemonBloc, PokemonState>(
                  builder: (context, state) {
                    if (state is PokemonLoadInProgress) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is PokemonPageLoadSuccess) {
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemCount: state.pokemonListings.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => BlocProvider.of<NavCubit>(context)
                                .showPokemonDetails(
                                    state.pokemonListings[index].id),
                            child: Card(
                              color: Color(
                                      (math.Random().nextDouble() * 0xFFFFFF)
                                          .toInt())
                                  .withOpacity(1.0),
                              margin: EdgeInsets.all(10),

                              // margin: EdgeInsets.fromLTRB(10, 10, 10, 35),
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: GridTile(
                                  child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        8.0, 8.0, 40.0, 0.0),
                                    child: Text(
                                      state.pokemonListings[index].name,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                  ),
                                  Container(
                                    height: 120,
                                    width: 160,
                                    alignment: Alignment.bottomRight,
                                    child: Image.network(
                                        state.pokemonListings[index].imageUrl),
                                  ),
                                ],
                              )),
                            ),
                          );
                        },
                      );
                    } else if (state is PokemonPageLoadFailed) {
                      print('llego aqui error');
                      return Center(
                        child: Text(state.error.toString()),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // final pokemonDetailsCubit = PokemonDetailsCubit();
          // MultiBlocProvider(providers: [
          //   BlocProvider(
          //       create: (context) =>
          //           PokemonBloc()..add(PokemonPageRequest(page: 0))),
          //   BlocProvider(
          //       create: (context) =>
          //           NavCubit(pokemonDetailsCubit: pokemonDetailsCubit)),
          //   BlocProvider(
          //       create: (context) =>
          //           NavCubit(pokemonDetailsCubit: pokemonDetailsCubit)),
          //   BlocProvider(
          //       create: (context) =>
          //           PokemonBloc()..add(PokemonPageRequest(page: 0)))
          // ], child: AppNavigator());

          //  BlocProvider.of<NavCubit>(context).showPokemonDetails(pokemonId);
        },
        child: const Icon(FontAwesomeIcons.bars),
        backgroundColor: Colors.purple,
      ),
    );
  }
}
