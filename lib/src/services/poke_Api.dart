

// ignore: library_prefixes
import 'package:http/http.dart' as Http;
import 'dart:convert';

import '../models/ability.dart';
import '../models/api.dart';
import '../models/berry.dart';
import '../models/common.dart';
import '../models/pokemon.dart';

class PokeAPI {
  static get _baseUrl => "https://pokeapi.co/api/v2/";

  static Future<Api> _getAPI() async {
    var response = await Http.get(Uri.parse(_baseUrl));
    Map map = json.decode(response.body);
    return Api.fromJson(map as Map<String, dynamic>);
  }

  static dynamic _mapJson<T>(Http.Response response) {
    Map? map = json.decode(response.body);

    if (T == Ability) return Ability.fromJson(map as Map<String, dynamic>) as T;
    if (T == Berry) return Berry.fromJson(map as Map<String, dynamic>) as T;
    if (T == Pokemon) return Pokemon.fromJson(map as Map<String, dynamic>) as T;
    if (T == Species) return Species.fromJson(map as Map<String, dynamic>) as T;
    if (T == Version) return Version.fromJson(map as Map<String, dynamic>) as T;
  }

  static Future<List<NamedAPIResource>?> getCommonList<T>(int offset, int limit) async {
    String url = await getBaseUrl<T>();

    url += "?offset=${offset - 1}&limit=$limit";
    var response = await Http.get(Uri.parse(url));
    Map listMap = json.decode(response.body);
    List<NamedAPIResource>? commonResultList = Common.fromJson(listMap as Map<String, dynamic>).results;

    return commonResultList;
  }

  static Future<List<T?>> getObjectList<T>(int offset, int limit) async {
    List<T?> objectList =  [];
    var url = await getBaseUrl<T>();

    url += "?offset=${offset - 1}&limit=$limit";
    var response = await Http.get(Uri.parse(url));
    Map listMap = json.decode(response.body);
    
    List<NamedAPIResource> commonResultList = Common.fromJson(listMap as Map<String, dynamic>).results!;

    for (NamedAPIResource result in commonResultList) {
      response = await Http.get(Uri.parse(result.url!));
      objectList.add(_mapJson<T>(response));
    }
    return objectList;
  }

  static Future<T?> getObject<T>(int id) async {
    String url = await getBaseUrl<T>();
    url += "?offset=${id - 1}&limit=1";
    var response = await Http.get(Uri.parse(url));
    Map listMap = json.decode(response.body);
    List<NamedAPIResource> commonResultList = Common.fromJson(listMap as Map<String, dynamic>).results!;

    if (commonResultList.isNotEmpty) {
      response = await Http.get(Uri.parse(commonResultList[0].url!));
      return _mapJson<T>(response);
    } else {
      return null;
    }
  }

  static getBaseUrl<T>() async {
    var api = await _getAPI();
    String? url;

    if (T == Pokemon) url = api.pokemon;
    if (T == Ability) url = api.ability;
    if (T == Berry) url = api.berry;
    if (T == Type) url = api.type;
    if (T == Species) url = api.pokemon_species;    
    if (T == Version) url = api.version;

    return url;
  }
}
