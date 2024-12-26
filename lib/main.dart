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
          'pk_details': (context) => const PokemonDetailPage(),
        },
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.black)),
        ),
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.teal,
            scaffoldBackgroundColor: Colors.black,
            textTheme:
                const TextTheme(bodyLarge: TextStyle(color: Colors.white)),
            cardTheme: const CardTheme(color: Colors.black45)),
        themeMode: ThemeMode.system,
        home: const HomePage(),
      ),
    );
  }
}
