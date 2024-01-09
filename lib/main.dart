

import 'package:flutter/material.dart';
import 'package:ladex/src/pages/pokemon_details_page.dart';
import 'src/pages/home_page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        'home': (BuildContext context) => const HomePage(),
        'pk_details':(context) => const PokemonDetailPage(),
        
      },
      theme: ThemeData(
        fontFamily: 'Montserrat-Regular',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}