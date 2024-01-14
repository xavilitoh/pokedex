// ignore_for_file: non_constant_identifier_names

class Api {
  String? ability;
  String? berry;
  String? berryFirmness;
  String? berryFlavor;
  String? characteristic;
  String? contestEffect;
  String? contestType;
  String? eggGroup;
  String? encounterCondition;
  String? encounterConditionValue;
  String? encounterMethod;
  String? evolutionChain;
  String? evolutionTrigger;
  String? gender;
  String? generation;
  String? growthRate;
  String? item;
  String? itemAttribute;
  String? itemCategory;
  String? itemFlingEffect;
  String? itemPocket;
  String? language;
  String? location;
  String? locationArea;
  String? machine;
  String? move;
  String? moveAilment;
  String? moveBattleStyle;
  String? moveCategory;
  String? moveDamageClass;
  String? moveLearnMethod;
  String? moveTarget;
  String? nature;
  String? palParkArea;
  String? pokeathlonStat;
  String? pokedex;
  String? pokemon;
  String? pokemonColor;
  String? pokemonForm;
  String? pokemonHabitat;
  String? pokemonShape;
  String? pokemonSpecies;
  String? region;
  String? stat;
  String? superContestEffect;
  String? type;
  String? version;
  String? versionGroup;
  String? pokemon_species;

  Api(
      {ability,
      berry,
      berryFirmness,
      berryFlavor,
      characteristic,
      contestEffect,
      contestType,
      eggGroup,
      encounterCondition,
      encounterConditionValue,
      encounterMethod,
      evolutionChain,
      evolutionTrigger,
      gender,
      generation,
      growthRate,
      item,
      itemAttribute,
      itemCategory,
      itemFlingEffect,
      itemPocket,
      language,
      location,
      locationArea,
      machine,
      move,
      moveAilment,
      moveBattleStyle,
      moveCategory,
      moveDamageClass,
      moveLearnMethod,
      moveTarget,
      nature,
      palParkArea,
      pokeathlonStat,
      pokedex,
      pokemon,
      pokemonColor,
      pokemonForm,
      pokemonHabitat,
      pokemonShape,
      pokemonSpecies,
      region,
      stat,
      superContestEffect,
      type,
      version,
      versionGroup,
      pokemon_species});

  Api.fromJson(Map<String, dynamic> json) {
    ability = json['ability'];
    berry = json['berry'];
    berryFirmness = json['berry-firmness'];
    berryFlavor = json['berry-flavor'];
    characteristic = json['characteristic'];
    contestEffect = json['contest-effect'];
    contestType = json['contest-type'];
    eggGroup = json['egg-group'];
    encounterCondition = json['encounter-condition'];
    encounterConditionValue = json['encounter-condition-value'];
    encounterMethod = json['encounter-method'];
    evolutionChain = json['evolution-chain'];
    evolutionTrigger = json['evolution-trigger'];
    gender = json['gender'];
    generation = json['generation'];
    growthRate = json['growth-rate'];
    item = json['item'];
    itemAttribute = json['item-attribute'];
    itemCategory = json['item-category'];
    itemFlingEffect = json['item-fling-effect'];
    itemPocket = json['item-pocket'];
    language = json['language'];
    location = json['location'];
    locationArea = json['location-area'];
    machine = json['machine'];
    move = json['move'];
    moveAilment = json['move-ailment'];
    moveBattleStyle = json['move-battle-style'];
    moveCategory = json['move-category'];
    moveDamageClass = json['move-damage-class'];
    moveLearnMethod = json['move-learn-method'];
    moveTarget = json['move-target'];
    nature = json['nature'];
    palParkArea = json['pal-park-area'];
    pokeathlonStat = json['pokeathlon-stat'];
    pokedex = json['pokedex'];
    pokemon = json['pokemon'];
    pokemonColor = json['pokemon-color'];
    pokemonForm = json['pokemon-form'];
    pokemonHabitat = json['pokemon-habitat'];
    pokemonShape = json['pokemon-shape'];
    pokemonSpecies = json['pokemon-species'];
    region = json['region'];
    stat = json['stat'];
    superContestEffect = json['super-contest-effect'];
    type = json['type'];
    version = json['version'];
    versionGroup = json['version-group'];
    pokemon_species = json['pokemon-species'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ability'] = ability;
    data['berry'] = berry;
    data['berry-firmness'] = berryFirmness;
    data['berry-flavor'] = berryFlavor;
    data['characteristic'] = characteristic;
    data['contest-effect'] = contestEffect;
    data['contest-type'] = contestType;
    data['egg-group'] = eggGroup;
    data['encounter-condition'] = encounterCondition;
    data['encounter-condition-value'] = encounterConditionValue;
    data['encounter-method'] = encounterMethod;
    data['evolution-chain'] = evolutionChain;
    data['evolution-trigger'] = evolutionTrigger;
    data['gender'] = gender;
    data['generation'] = generation;
    data['growth-rate'] = growthRate;
    data['item'] = item;
    data['item-attribute'] = itemAttribute;
    data['item-category'] = itemCategory;
    data['item-fling-effect'] = itemFlingEffect;
    data['item-pocket'] = itemPocket;
    data['language'] = language;
    data['location'] = location;
    data['location-area'] = locationArea;
    data['machine'] = machine;
    data['move'] = move;
    data['move-ailment'] = moveAilment;
    data['move-battle-style'] = moveBattleStyle;
    data['move-category'] = moveCategory;
    data['move-damage-class'] = moveDamageClass;
    data['move-learn-method'] = moveLearnMethod;
    data['move-target'] = moveTarget;
    data['nature'] = nature;
    data['pal-park-area'] = palParkArea;
    data['pokeathlon-stat'] = pokeathlonStat;
    data['pokedex'] = pokedex;
    data['pokemon'] = pokemon;
    data['pokemon-color'] = pokemonColor;
    data['pokemon-form'] = pokemonForm;
    data['pokemon-habitat'] = pokemonHabitat;
    data['pokemon-shape'] = pokemonShape;
    data['pokemon-species'] = pokemonSpecies;
    data['region'] = region;
    data['stat'] = stat;
    data['super-contest-effect'] = superContestEffect;
    data['type'] = type;
    data['version'] = version;
    data['version-group'] = versionGroup;
    return data;
  }

  @override
  String toString() {
    return 'ApiDao{ability: $ability, berry: $berry, berryFirmness: $berryFirmness, berryFlavor: $berryFlavor, characteristic: $characteristic, contestEffect: $contestEffect, contestType: $contestType, eggGroup: $eggGroup, encounterCondition: $encounterCondition, encounterConditionValue: $encounterConditionValue, encounterMethod: $encounterMethod, evolutionChain: $evolutionChain, evolutionTrigger: $evolutionTrigger, gender: $gender, generation: $generation, growthRate: $growthRate, item: $item, itemAttribute: $itemAttribute, itemCategory: $itemCategory, itemFlingEffect: $itemFlingEffect, itemPocket: $itemPocket, language: $language, location: $location, locationArea: $locationArea, machine: $machine, move: $move, moveAilment: $moveAilment, moveBattleStyle: $moveBattleStyle, moveCategory: $moveCategory, moveDamageClass: $moveDamageClass, moveLearnMethod: $moveLearnMethod, moveTarget: $moveTarget, nature: $nature, palParkArea: $palParkArea, pokeathlonStat: $pokeathlonStat, pokedex: $pokedex, pokemon: $pokemon, pokemonColor: $pokemonColor, pokemonForm: $pokemonForm, pokemonHabitat: $pokemonHabitat, pokemonShape: $pokemonShape, pokemonSpecies: $pokemonSpecies, region: $region, stat: $stat, superContestEffect: $superContestEffect, type: $type, version: $version, versionGroup: $versionGroup}';
  }
}
