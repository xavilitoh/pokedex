import 'package:pokeapi/model/pokemon/pokemon.dart';
import 'package:pokeapi/pokeapi.dart';
import 'package:rxdart/rxdart.dart';


class PokemonBloc{
  final _pokemones = BehaviorSubject<List<Pokemon?>>();
  final _pokemon = BehaviorSubject<Pokemon?>();

  Stream<List<Pokemon?>> get pokemones => _pokemones.stream;
  Stream<Pokemon?> get pokemon => _pokemon.stream;

  Future getPokemon(int id) async {    
    var response = await PokeAPI.getObject<Pokemon>(id);
    _pokemon.sink.add(response);
  }

  Future setPokemon(Pokemon? pokemon) async {
    _pokemon.sink.add(pokemon);
  }

  Future getPokemones({int offset = 1, int limit = 10}) async {
    
    var response = await PokeAPI.getObjectList<Pokemon>(offset, limit);
    _pokemones.sink.add(response);
  }

  Future getPagesPokemones({int offset = 1, int limit = 10}) async {
    var list = _pokemones.value;
    
    var response = await PokeAPI.getObjectList<Pokemon>(offset, limit);
    list.addAll(response);
    _pokemones.sink.add(list);
  }
}