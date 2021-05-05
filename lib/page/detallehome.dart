import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pokemon/bloc/pokemon_details_cubit.dart';

import '../pokemon_details.dart';

class PokemonDetailsView extends StatelessWidget {
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
    index = random.nextInt(1);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
              icon: Icon(
                FontAwesomeIcons.heart,
                color: Colors.white,
              ),
              onPressed: () {
                print('menu');
              })
        ],
      ),
      backgroundColor: Color(0xFFF2F2F2),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<PokemonDetailsCubit, PokemonDetails>(
                  builder: (context, details) {
                    return details != null
                        ? Center(
                            child: Column(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 900,
                                    color: Colors.blue,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              16.0, 8.0, 0.0, 8.0),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              details.name,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 45,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0.0, 0.0, 40.0, 0.0),
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: Text(
                                              ' # ${details.id.toString()}',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              16.0, 8.0, 0.0, 0.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: details.types
                                                .map((type) =>
                                                    _pokemonTypeView(type))
                                                .toList(),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Hero(
                                              tag: details.imageUrl,
                                              child: Container(
                                                height: 100,
                                                width: 400,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            details.imageUrl))),
                                              )
                                              //Image.network(
                                              // details.imageUrl)
                                              ),
                                        ),

                                        Positioned(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              1.5,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              20,
                                          left: 10.0,
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.62,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                1.2,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0)),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                  Text('Descripcion',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 35,
                                                          fontWeight:
                                                              FontWeight.w900)),
                                                  Text(
                                                    details.description,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text('Peso: ',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900)),
                                                      Text(
                                                        details.weight
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      SizedBox(
                                                        width: 50,
                                                      ),
                                                      Text('Altura: ',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900)),
                                                      Text(
                                                        details.height
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                        // Image.network(details.imageUrl),
                                        // Text(
                                        //     'ID: ${details.id}  -  Weight: ${details.weight}  -  Height: ${details.height}')
                                      ],
                                    ),
                                  )),
                              // Expanded(
                              //     flex: 2,
                              //     child: SizedBox(
                              //       width: double.infinity,
                              //       child: Card(
                              //         child: Padding(
                              //           padding: EdgeInsets.all(8),
                              //           child: Text(
                              //             details.description,
                              //             textAlign: TextAlign.center,
                              //           ),
                              //         ),
                              //       ),
                              //     ))
                            ],
                          ))
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pokemonTypeView(String type) {
    Color color;

    switch (type) {
      case 'normal':
        color = Colors.grey[600];
        break;
      case 'poison':
        color = Colors.grey[600];
        break;
      case 'psychic':
        color = Colors.grey[600];
        break;
      case 'grass':
        color = Colors.grey[600];
        break;
      case 'ground':
        color = Colors.grey[600];
        break;
      case 'ice':
        color = Colors.grey[600];
        break;
      case 'fire':
        color = Colors.grey[600];
        break;
      case 'rock':
        color = Colors.grey[600];
        break;
      case 'dragon':
        color = Colors.grey[600];
        break;
      case 'water':
        color = Colors.grey[600];
        break;
      case 'bug':
        color = Colors.grey[600];
        break;
      case 'dark':
        color = Colors.grey[600];
        break;
      case 'fighting':
        color = Colors.grey[600];
        break;
      case 'ghost':
        color = Colors.grey[600];
        break;
      case 'steel':
        color = Colors.grey[600];
        break;
      case 'flying':
        color = Colors.grey[600];
        break;
      case 'normal':
        color = Colors.grey[600];
        break;
      case 'fairy':
        color = Colors.grey[600];
        break;
      default:
        color = Colors.grey[600];
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Text(
          type.toUpperCase(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
