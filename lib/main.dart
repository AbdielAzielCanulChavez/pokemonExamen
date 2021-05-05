import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:pokemon/app_navigator.dart';
import 'package:pokemon/bloc/pokemon_block.dart';
import 'package:pokemon/bloc/pokemon_event.dart';
import 'package:pokemon/page/capturaDatos.dart';
import 'package:pokemon/page/home.dart';
import 'package:pokemon/page/splashScreen.dart';
import 'package:pokemon/preferencias/variablesglobales.dart';

import 'bloc/nav_cubit.dart';
import 'bloc/pokemon_details_cubit.dart';

Future<void> main() async {
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String route = '/home';

  @override
  Widget build(BuildContext context) {
    final pokemonDetailsCubit = PokemonDetailsCubit();
    String route = '/home';

    if (prefs.nombreUsuario != "" && prefs.nombreUsuario != null) {
      MultiBlocProvider(providers: [
        BlocProvider(
            create: (context) =>
                PokemonBloc()..add(PokemonPageRequest(page: 0))),
        BlocProvider(
            create: (context) =>
                NavCubit(pokemonDetailsCubit: pokemonDetailsCubit)),
        BlocProvider(create: (context) => pokemonDetailsCubit)
      ], child: AppNavigator());
      //route = "/home";
    } else {
      route = '/cargarNombre';
    }

    return GetMaterialApp(
      locale: Locale('es', 'ES'),
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('es', 'ES'),
        const Locale('en', 'US'),
      ],
      debugShowCheckedModeBanner: false,
      title: 'POKEMON APP',
      getPages: [
        GetPage(
          name: '/',
          page: () => SplashScreen(
            route: route,
          ),
        ),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/cargarNombre', page: () => CapturaDatos()),
      ],
    );
  }
}
