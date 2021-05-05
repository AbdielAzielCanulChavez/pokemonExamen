import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/bloc/nav_cubit.dart';
import 'package:pokemon/bloc/pokemon_block.dart';
import 'package:pokemon/bloc/pokemon_state.dart';

bool banderaDe = true;

class EquiposPokemon extends StatefulWidget {
  @override
  _EquiposPokemonState createState() => _EquiposPokemonState();
}

class _EquiposPokemonState extends State<EquiposPokemon> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    banderaDe = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(172, 39, 47, 1),
        elevation: 0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "POKEDEX",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is PokemonLoadInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PokemonPageLoadSuccess) {
            return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: state.pokemonListings.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  // onTap: () => BlocProvider.of<NavCubit>(context)
                  //     .showPokemonDetails(state.pokemonListings[index].id),
                  child: Card(
                    child: GridTile(
                        child: Column(
                      children: [
                        Image.network(state.pokemonListings[index].imageUrl),
                        Text(state.pokemonListings[index].name)
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
    );
  }
}
