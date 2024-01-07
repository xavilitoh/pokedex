import 'package:pokeapi/model/pokemon/pokemon.dart';
import 'package:pokeapi/pokeapi.dart';
import 'package:rxdart/rxdart.dart';


class PokemonBloc{
  final _pokemones = BehaviorSubject<List<Pokemon?>>();

  Stream<List<Pokemon?>> get pokemones => _pokemones.stream; 

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