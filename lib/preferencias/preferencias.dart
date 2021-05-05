import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences prefs;

  initPrefs() async {
    WidgetsFlutterBinding.ensureInitialized();
    this.prefs = await SharedPreferences.getInstance();
  }

//este prefs es usado para almacenar el nombre del usuario
  String get nombreUsuario {
    return this.prefs.getString('nombreUsuario') ?? '';
  }

  set nombreUsuario(String nombreUsuario) {
    this.prefs?.setString('nombreUsuario', nombreUsuario);
  }
}
