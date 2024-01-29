

import 'package:flutter/material.dart';
import 'package:ladex/src/blocs/bloc_provider.dart';
import 'package:ladex/src/pages/pokemon_details/pokemon_details_page.dart';
import 'src/pages/pokedex/home_page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(      
      child: MaterialApp(
        title: 'Pokedex',
        routes: {
          'home': (BuildContext context) => const HomePage(),
          'pk_details':(context) => const PokemonDetailPage(),
          
        },
        theme: ThemeData(
          fontFamily: 'HankRnd-Regular',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}