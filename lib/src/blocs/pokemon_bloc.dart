// import 'package:pokeapi/model/pokemon/pokemon.dart';
// import 'package:pokeapi/pokeapi.dart';
import 'package:rxdart/rxdart.dart';

import '../models/pokemon_b.dart';
import '../providers/pokemos/pokemon_search_provider.dart';


class PokemonBloc{
  final _pokemones = BehaviorSubject<List<PokemonB?>>();
  // ignore: non_constant_identifier_names
  final _LineaEvolutiva = BehaviorSubject<List<PokemonB?>>();
  final _pokemonesSearch = BehaviorSubject<List<PokemonB?>>();
  final _pokemon = BehaviorSubject<PokemonB?>();

  Stream<List<PokemonB?>> get pokemones => _pokemones.stream;
  Stream<List<PokemonB?>> get pokemonesSearch => _pokemonesSearch.stream;
  Stream<List<PokemonB?>> get lineaEvolutiva => _LineaEvolutiva.stream;
  Stream<PokemonB?> get pokemon => _pokemon.stream;

  Future getPokemon(String id) async {    
    var response = _pokemones.value.where((element) => element?.id == id);
    _pokemon.sink.add(response.first);
  }

  Future setPokemon(PokemonB? pokemon) async {
    _pokemon.sink.add(pokemon);
  }

  Future evoluciones(List<dynamic>? evols)async{

    List<PokemonB> evoluciones = [];
    var response = await PokemonSearchProvider.readJsonFile();

    evols?.forEach((evolucion) {
      var poke = response.firstWhere((element) => element.name == evolucion);
      evoluciones.add(poke);
    });

    _LineaEvolutiva.sink.add(evoluciones);

  }

  Future getPokemones({int offset = 1, int limit = 10}) async {
    
    var response = await PokemonSearchProvider.readJsonFile();
    _pokemones.sink.add(response);
  }

  Future searchPokemones(String query) async {    
    var response = await PokemonSearchProvider.readJsonFile();
  
    var t = response.where((element) => element.name?.toLowerCase().contains(query) == true).toList();

    _pokemonesSearch.sink.add(t);
  }

  Future getPagesPokemones({int offset = 1, int limit = 10}) async {
    var list = _pokemones.value;
    
    var response = await PokemonSearchProvider.readJsonFile();
    list.addAll(response);
    _pokemones.sink.add(list);
  }
}