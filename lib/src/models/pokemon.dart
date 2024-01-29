

import 'package:ladex/src/utils/constants.dart';

import 'common.dart';

class Pokemon {
  int? id;
  String? name;
  int? baseExperience;
  int? height;
  bool? isDefault;
  int? order;
  int? weight;
  List<Abilities>? abilities;
  List<NamedAPIResource>? forms;
  List<GameIndices>? gameIndices;
  List<HeldItems>? heldItems;
  List<Moves>? moves;
  NamedAPIResource? species;
  Sprites? sprites;
  List<Stats>? stats;
  List<Types>? types;

  Pokemon(
      {id,
      name,
      baseExperience,
      height,
      isDefault,
      order,
      weight,
      abilities,
      forms,
      gameIndices,
      heldItems,
      moves,
      species,
      sprites,
      stats,
      types});

  Pokemon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    baseExperience = json['base_experience'];
    height = json['height'];
    isDefault = json['is_default'];
    order = json['order'];
    weight = json['weight'];
    if (json['abilities'] != null) {
      abilities =  <Abilities>[];
      json['abilities'].forEach((v) {
        abilities!.add( Abilities.fromJson(v));
      });
    }
    if (json['forms'] != null) {
      forms =  <NamedAPIResource>[];
      json['forms'].forEach((v) {
        forms!.add( NamedAPIResource.fromJson(v));
      });
    }
    if (json['game_indices'] != null) {
      gameIndices =  <GameIndices>[];
      json['game_indices'].forEach((v) {
        gameIndices!.add( GameIndices.fromJson(v));
      });
    }
    if (json['held_items'] != null) {
      heldItems =  <HeldItems>[];
      json['held_items'].forEach((v) {
        heldItems!.add( HeldItems.fromJson(v));
      });
    }
    if (json['moves'] != null) {
      moves =  <Moves>[];
      json['moves'].forEach((v) {
        moves!.add( Moves.fromJson(v));
      });
    }
    species = json['species'] != null
        ?  NamedAPIResource.fromJson(json['species'])
        : null;
    sprites =
        json['sprites'] != null ?  Sprites.fromJson(json['sprites']) : null;
    if (json['stats'] != null) {
      stats =  <Stats>[];
      json['stats'].forEach((v) {
        stats!.add( Stats.fromJson(v));
      });
    }
    if (json['types'] != null) {
      types =  <Types>[];
      json['types'].forEach((v) {
        types!.add( Types.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['base_experience'] = baseExperience;
    data['height'] = height;
    data['is_default'] = isDefault;
    data['order'] = order;
    data['weight'] = weight;
    if (abilities != null) {
      data['abilities'] = abilities!.map((v) => v.toJson()).toList();
    }
    if (forms != null) {
      data['forms'] = forms!.map((v) => v.toJson()).toList();
    }
    if (gameIndices != null) {
      data['game_indices'] = gameIndices!.map((v) => v.toJson()).toList();
    }
    if (heldItems != null) {
      data['held_items'] = heldItems!.map((v) => v.toJson()).toList();
    }
    if (moves != null) {
      data['moves'] = moves!.map((v) => v.toJson()).toList();
    }
    if (species != null) {
      data['species'] = species!.toJson();
    }
    if (sprites != null) {
      data['sprites'] = sprites!.toJson();
    }
    if (stats != null) {
      data['stats'] = stats!.map((v) => v.toJson()).toList();
    }
    if (types != null) {
      data['types'] = types!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'Pokemon{id: $id, name: $name, baseExperience: $baseExperience, height: $height, isDefault: $isDefault, order: $order, weight: $weight, abilities: $abilities, forms: $forms, gameIndices: $gameIndices, heldItems: $heldItems, moves: $moves, species: $species, sprites: $sprites, stats: $stats, types: $types}';
  }
}

class Abilities {
  bool? isHidden;
  int? slot;
  NamedAPIResource? ability;

  Abilities({isHidden, slot, ability});

  Abilities.fromJson(Map<String, dynamic> json) {
    isHidden = json['is_hidden'];
    slot = json['slot'];
    ability = json['ability'] != null
        ?  NamedAPIResource.fromJson(json['ability'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['is_hidden'] = isHidden;
    data['slot'] = slot;
    if (ability != null) {
      data['ability'] = ability!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'Abilities{isHidden: $isHidden, slot: $slot, ability: $ability}';
  }
}

class GameIndices {
  int? gameIndex;
  NamedAPIResource? version;

  GameIndices({gameIndex, version});

  GameIndices.fromJson(Map<String, dynamic> json) {
    gameIndex = json['game_index'];
    version = json['version'] != null
        ?  NamedAPIResource.fromJson(json['version'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['game_index'] = gameIndex;
    if (version != null) {
      data['version'] = version!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'GameIndices{gameIndex: $gameIndex, version: $version}';
  }
}

class HeldItems {
  NamedAPIResource? item;
  List<VersionDetails>? versionDetails;

  HeldItems({item, versionDetails});

  HeldItems.fromJson(Map<String, dynamic> json) {
    item = json['item'] != null
        ?  NamedAPIResource.fromJson(json['item'])
        : null;
    if (json['version_details'] != null) {
      versionDetails =  <VersionDetails>[];
      json['version_details'].forEach((v) {
        versionDetails!.add( VersionDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (item != null) {
      data['item'] = item!.toJson();
    }
    if (versionDetails != null) {
      data['version_details'] =
          versionDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'HeldItems{item: $item, versionDetails: $versionDetails}';
  }
}

class VersionDetails {
  int? rarity;
  NamedAPIResource? version;

  VersionDetails({rarity, version});

  VersionDetails.fromJson(Map<String, dynamic> json) {
    rarity = json['rarity'];
    version = json['version'] != null
        ?  NamedAPIResource.fromJson(json['version'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['rarity'] = rarity;
    if (version != null) {
      data['version'] = version!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'VersionDetails{rarity: $rarity, version: $version}';
  }
}

class EncounterDetails {
  int? minLevel;
  int? maxLevel;
  List<ConditionValues>? conditionValues;
  int? chance;
  Method? method;

  EncounterDetails(
      {minLevel,
      maxLevel,
      conditionValues,
      chance,
      method});

  EncounterDetails.fromJson(Map<String, dynamic> json) {
    minLevel = json['min_level'];
    maxLevel = json['max_level'];
    if (json['condition_values'] != null) {
      conditionValues =  <ConditionValues>[];
      json['condition_values'].forEach((v) {
        conditionValues!.add( ConditionValues.fromJson(v));
      });
    }
    chance = json['chance'];
    method =
        json['method'] != null ?  Method.fromJson(json['method']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['min_level'] = minLevel;
    data['max_level'] = maxLevel;
    if (conditionValues != null) {
      data['condition_values'] =
          conditionValues!.map((v) => v.toJson()).toList();
    }
    data['chance'] = chance;
    if (method != null) {
      data['method'] = method!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'EncounterDetails{minLevel: $minLevel, maxLevel: $maxLevel, conditionValues: $conditionValues, chance: $chance, method: $method}';
  }
}

class ConditionValues {
  String? name;
  String? url;

  ConditionValues({name, url});

  ConditionValues.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }

  @override
  String toString() {
    return 'ConditionValues{name: $name, url: $url}';
  }
}

class Method {
  String? name;
  String? url;

  Method({name, url});

  Method.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }

  @override
  String toString() {
    return 'Method{name: $name, url: $url}';
  }
}

class Moves {
  NamedAPIResource? move;
  List<VersionGroupDetails>? versionGroupDetails;

  Moves({move, versionGroupDetails});

  Moves.fromJson(Map<String, dynamic> json) {
    move = json['move'] != null
        ?  NamedAPIResource.fromJson(json['move'])
        : null;
    if (json['version_group_details'] != null) {
      versionGroupDetails =  <VersionGroupDetails>[];
      json['version_group_details'].forEach((v) {
        versionGroupDetails!.add( VersionGroupDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (move != null) {
      data['move'] = move!.toJson();
    }
    if (versionGroupDetails != null) {
      data['version_group_details'] =
          versionGroupDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'Moves{move: $move, versionGroupDetails: $versionGroupDetails}';
  }
}

class VersionGroupDetails {
  int? levelLearnedAt;
  NamedAPIResource? versionGroup;
  NamedAPIResource? moveLearnMethod;

  VersionGroupDetails(
      {levelLearnedAt, versionGroup, moveLearnMethod});

  VersionGroupDetails.fromJson(Map<String, dynamic> json) {
    levelLearnedAt = json['level_learned_at'];
    versionGroup = json['version_group'] != null
        ?  NamedAPIResource.fromJson(json['version_group'])
        : null;
    moveLearnMethod = json['move_learn_method'] != null
        ?  NamedAPIResource.fromJson(json['move_learn_method'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['level_learned_at'] = levelLearnedAt;
    if (versionGroup != null) {
      data['version_group'] = versionGroup!.toJson();
    }
    if (moveLearnMethod != null) {
      data['move_learn_method'] = moveLearnMethod!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'VersionGroupDetails{levelLearnedAt: $levelLearnedAt, versionGroup: $versionGroup, moveLearnMethod: $moveLearnMethod}';
  }
}

class Sprites {
  String? backFemale;
  String? backShinyFemale;
  String? backDefault;
  String? frontFemale;
  String? frontShinyFemale;
  String? backShiny;
  String? frontDefault;
  String? frontShiny;

  Sprites(
      {backFemale,
      backShinyFemale,
      backDefault,
      frontFemale,
      frontShinyFemale,
      backShiny,
      frontDefault,
      frontShiny});

  Sprites.fromJson(Map<String, dynamic> json) {
    backFemale = json['back_female'];
    backShinyFemale = json['back_shiny_female'];
    backDefault = json['back_default'];
    frontFemale = json['front_female'];
    frontShinyFemale = json['front_shiny_female'];
    backShiny = json['back_shiny'];
    frontDefault = json['front_default'];
    frontShiny = json['front_shiny'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['back_female'] = backFemale;
    data['back_shiny_female'] = backShinyFemale;
    data['back_default'] = backDefault;
    data['front_female'] = frontFemale;
    data['front_shiny_female'] = frontShinyFemale;
    data['back_shiny'] = backShiny;
    data['front_default'] = frontDefault;
    data['front_shiny'] = frontShiny;
    return data;
  }

  @override
  String toString() {
    return 'Sprites{backFemale: $backFemale, backShinyFemale: $backShinyFemale, backDefault: $backDefault, frontFemale: $frontFemale, frontShinyFemale: $frontShinyFemale, backShiny: $backShiny, frontDefault: $frontDefault, frontShiny: $frontShiny}';
  }
}

class Stats {
  int? baseStat;
  int? effort;
  NamedAPIResource? stat;

  Stats({baseStat, effort, stat});

  Stats.fromJson(Map<String, dynamic> json) {
    baseStat = json['base_stat'];
    effort = json['effort'];
    stat = json['stat'] != null
        ?  NamedAPIResource.fromJson(json['stat'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['base_stat'] = baseStat;
    data['effort'] = effort;
    if (stat != null) {
      data['stat'] = stat!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'Stats{baseStat: $baseStat, effort: $effort, stat: $stat}';
  }
}

class Types {
  int? slot;
  NamedAPIResource? type;

  Types({slot, type});

  Types.fromJson(Map<String, dynamic> json) {
    slot = json['slot'];
    type = json['type'] != null
        ?  NamedAPIResource.fromJson(json['type'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['slot'] = slot;
    if (type != null) {
      data['type'] = type!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'Types{slot: $slot, type: $type}';
  }
}


class Species {
    int? baseHappiness;
    int? captureRate;
    String? flavorTextEntry;
    // Color? color;
    // List<Color>? eggGroups;
    // EvolutionChain? evolutionChain;
    // dynamic evolvesFromSpecies;
    // List<dynamic>? formDescriptions;
    // bool? formsSwitchable;
    // int? genderRate;
    // List<Genus>? genera;
    // Color? generation;
    // Color? growthRate;
    // Color? habitat;
    // bool? hasGenderDifferences;
    // int? hatchCounter;
    // int? id;
    // bool? isBaby;
    // bool? isLegendary;
    // bool? isMythical;
    
    String? name;
    // List<Name>? names;
    // int? order;
    // Color? shape;
    String version = 'none';
    String desc = '';

    Species({
        baseHappiness,
        captureRate,
        flavorTextEntry,
        name
    });

    Species.fromJson(Map<String, dynamic> json) {

      int i = 42;
      
      baseHappiness = json['base_happiness'] ;
      captureRate = json['capture_rate'];
      name = json['name'];
      if (json['flavor_text_entries'] != null) {
      json['flavor_text_entries'].forEach((v) {

        var data = FlavorTextEntry.fromJson(v);
        if(data.language?.name == 'es' && version == 'none'){
           version = setDescripcion(i, 'es', data);
        }

        if(data.language?.name == 'es' && data.version?.name == version){
          desc = '$desc ${data.flavorText}';
        }
        
      });

      flavorTextEntry = desc + version;
    }
    }
}

String setDescripcion( int versionIndex, String lenguaje, FlavorTextEntry ft){

    String version = versiones[versionIndex];
    if(ft.language?.name == 'es'){
      if(ft.version?.name == version){
        return version;
      }else{
        version = setDescripcion(versionIndex - 1,lenguaje, ft);
      }
    }

    return version;
}

class FlavorTextEntry {
    String? flavorText;
    NamedAPIResource? language;
    NamedAPIResource? version;

    FlavorTextEntry({
        flavorText,
        language,
        version,
    });


    FlavorTextEntry.fromJson(Map<String, dynamic> json){
      flavorText = json['flavor_text'];
      language = json['language'] != null
        ?  NamedAPIResource.fromJson(json['language'])
        : null;
      version = json['version'] != null
        ?  NamedAPIResource.fromJson(json['version'])
        : null;
    }
}


class Genus {
    String? genus;
    NamedAPIResource? language;

    Genus({
        genus,
        language,
    });
}


class Name {
    NamedAPIResource? language;
    String? name;

    Name({
        language,
        name,
    });
}


class PalParkEncounter {
    NamedAPIResource? area;
    int? baseScore;
    int? rate;

    PalParkEncounter({
        area,
        baseScore,
        rate,
    });
}


class PokedexNumber {
    int? entryNumber;
    NamedAPIResource? pokedex;

    PokedexNumber({
        entryNumber,
        pokedex,
    });
}


class Variety {
    bool? isDefault;
    NamedAPIResource? pokemon;

    Variety({
        isDefault,
        pokemon,
    });
}

