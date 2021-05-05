import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pokemon/bloc/nav_cubit.dart';
import 'package:pokemon/bloc/pokemon_block.dart';
import 'package:pokemon/bloc/pokemon_details_cubit.dart';
import 'package:pokemon/bloc/pokemon_event.dart';
import 'package:pokemon/page/home.dart';
import 'package:pokemon/page/splashScreen.dart';
import 'package:pokemon/preferencias/variablesglobales.dart';
import 'package:pokemon/widget/capturaErrores.dart';
import 'package:toast/toast.dart';

import '../app_navigator.dart';

class CapturaDatos extends StatefulWidget {
  @override
  _CapturaDatosState createState() => _CapturaDatosState();
}

class _CapturaDatosState extends State<CapturaDatos> {
  final pokemonDetailsCubit = PokemonDetailsCubit();
  final _formKey = GlobalKey<FormState>();
  TextEditingController nombreUsuarioTextEdit = TextEditingController();

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
      body: Container(
        child: Center(
          child: Column(
            children: [
              Container(
                color: Color.fromRGBO(172, 39, 47, 1),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const ListTile(
                      title: Text(
                        "BIENVENIDO A TU AVENTURA POKEMON",
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Color.fromRGBO(221, 201, 163, 1)),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        _nombre(),
                        _botonRegistro(context),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _registrarUsuario() {
    if (_formKey.currentState.validate()) {
      BuildContext circular = context;
      showDialog(
          context: circular,
          builder: (BuildContext context) {
            return Lottie.asset('assets/loading.json');
          });

      if (nombreUsuarioTextEdit.text != "" &&
          nombreUsuarioTextEdit.text != null) {
        prefs.nombreUsuario = nombreUsuarioTextEdit.text;
        print(prefs.nombreUsuario.toString());

        Toast.show('Se guardo con éxito', context,
            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);

        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return SplashScreen(
            route: '/home',
          );
        }));
      } else {
        //Navigator.pop(circular);
        alertError(context, 'Ups!!!', 'No puedes dejar tu nombre en blanco');
        //No puedes dejar el campo en blanco
      }
    }
  }

  Widget _botonRegistro(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 10, 5, 2),
      child: RaisedButton(
        // padding: EdgeInsets.all(),
        onPressed: () {
          _registrarUsuario();
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
        elevation: 0,

        color: Color.fromRGBO(172, 39, 47, 1),
        textColor: Colors.white,
        child: Text(
          'Registrar',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _nombre() {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 25, right: 25, bottom: 4),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
            child: Text('  Nombre de entrenador',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(70, 70, 70, 1),
                  fontSize: 16,
                )),
          ),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Debes llenar todos los campos';
              }
              return null;
            },
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.text,
            controller: nombreUsuarioTextEdit,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              // prefixIcon: Icon(
              //   FontAwesomeIcons.solidUser,
              //   color: Colors.grey,
              // ),
              hintText: 'Nombre de entrenador pokemon',
            ),
          ),
        ],
      ),
    );
  }
}
