import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ladex/src/models/pokemon_b.dart';

 class PokemonSearchProvider{

  static Future<List<PokemonB>> readJsonFile() async {
    var input = await rootBundle.loadString('assets/files/pokemons.json');
    var map = json.decode(input);
    
    List<PokemonB> pokemones = [];

    for ( var item in map  ) {
      final poke = PokemonB.fromJson(item);      
      pokemones.add( poke );
    }

    return pokemones;
  }

}