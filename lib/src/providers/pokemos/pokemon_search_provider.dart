import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ladex/src/models/pokemon_b.dart';

import '../../utils/constants.dart';

 class PokemonSearchProvider{

  static Future<List<PokemonB>> readJsonFile() async {

    if (pokemonFileData.isEmpty) {
      var input = await rootBundle.loadString(pokemonFile);
      var map = json.decode(input);
      
      pokemonFileData = [];

      for ( var item in map  ) {
        final poke = PokemonB.fromJson(item);      
        pokemonFileData.add( poke );
      }
    }

    return pokemonFileData;
  }

}