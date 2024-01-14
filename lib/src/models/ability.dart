

import 'common.dart';

class Ability {
  int? id;
  String? name;
  bool? isMainSeries;
  NamedAPIResource? generation;
  List<Names>? names;
  List<AbilityEffectEntries>? effectEntries;
  List<AbilityEffectChanges>? effectChanges;
  List<AbilityFlavorTextEntries>? flavorTextEntries;
  List<NamedAPIResource>? pokemon;

  Ability(
      {id,
      name,
      isMainSeries,
      generation,
      names,
      effectEntries,
      effectChanges,
      flavorTextEntries,
      pokemon});

  Ability.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isMainSeries = json['is_main_series'];
    generation = json['generation'] != null
        ?  NamedAPIResource.fromJson(json['generation'])
        : null;
    if (json['names'] != null) {
      names = <Names>[];
      json['names'].forEach((v) {
        names!.add( Names.fromJson(v));
      });
    }
    if (json['effect_entries'] != null) {
      effectEntries = <AbilityEffectEntries>[];
      json['effect_entries'].forEach((v) {
        effectEntries!.add( AbilityEffectEntries.fromJson(v));
      });
    }
    if (json['effect_changes'] != null) {
      effectChanges = <AbilityEffectChanges>[];
      json['effect_changes'].forEach((v) {
        effectChanges!.add( AbilityEffectChanges.fromJson(v));
      });
    }
    if (json['flavor_text_entries'] != null) {
      flavorTextEntries = <AbilityFlavorTextEntries>[];
      json['flavor_text_entries'].forEach((v) {
        flavorTextEntries!.add( AbilityFlavorTextEntries.fromJson(v));
      });
    }
    if (json['pokemon'] != null) {
      pokemon = <NamedAPIResource>[];
      json['pokemon'].forEach((v) {
        v = v['pokemon'];
        pokemon!.add( NamedAPIResource.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['is_main_series'] = isMainSeries;
    if (generation != null) {
      data['generation'] = generation!.toJson();
    }
    if (names != null) {
      data['names'] = names!.map((v) => v.toJson()).toList();
    }
    if (effectEntries != null) {
      data['effect_entries'] =
          effectEntries!.map((v) => v.toJson()).toList();
    }
    if (effectChanges != null) {
      data['effect_changes'] =
          effectChanges!.map((v) => v.toJson()).toList();
    }
    if (flavorTextEntries != null) {
      data['flavor_text_entries'] =
          flavorTextEntries!.map((v) => v.toJson()).toList();
    }
    if (pokemon != null) {
      data['pokemon'] = pokemon!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'Ability{id: $id, name: $name, isMainSeries: $isMainSeries, generation: $generation, names: $names, effectEntries: $effectEntries, effectChanges: $effectChanges, flavorTextEntries: $flavorTextEntries, pokemon: $pokemon}';
  }
}

class Names {
  String? name;
  NamedAPIResource? language;

  Names({name, language});

  Names.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    language = json['language'] != null
        ?  NamedAPIResource.fromJson(json['language'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    if (language != null) {
      data['language'] = language!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'Names{name: $name, language: $language}';
  }
}

class AbilityEffectEntries {
  String? effect;
  String? shortEffect;
  NamedAPIResource? language;

  AbilityEffectEntries({effect, shortEffect, language});

  AbilityEffectEntries.fromJson(Map<String, dynamic> json) {
    effect = json['effect'];
    shortEffect = json['short_effect'];
    language = json['language'] != null
        ?  NamedAPIResource.fromJson(json['language'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['effect'] = effect;
    data['short_effect'] = shortEffect;
    if (language != null) {
      data['language'] = language!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'AbilityEffectEntries{effect: $effect, shortEffect: $shortEffect, language: $language}';
  }
}

class AbilityEffectChanges {
  NamedAPIResource? versionGroup;
  List<AbilityEffectEntries>? effectEntries;

  AbilityEffectChanges({versionGroup, effectEntries});

  AbilityEffectChanges.fromJson(Map<String, dynamic> json) {
    versionGroup = json['version_group'] != null
        ?  NamedAPIResource.fromJson(json['version_group'])
        : null;
    if (json['effect_entries'] != null) {
      effectEntries =  <AbilityEffectEntries>[];
      json['effect_entries'].forEach((v) {
        effectEntries!.add( AbilityEffectEntries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (versionGroup != null) {
      data['version_group'] = versionGroup!.toJson();
    }
    if (effectEntries != null) {
      data['effect_entries'] =
          effectEntries!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'AbilityEffectChanges{versionGroup: $versionGroup, effectEntries: $effectEntries}';
  }
}

class AbilityFlavorTextEntries {
  String? flavorText;
  NamedAPIResource? language;
  NamedAPIResource? versionGroup;

  AbilityFlavorTextEntries({flavorText, language, versionGroup});

  AbilityFlavorTextEntries.fromJson(Map<String, dynamic> json) {
    flavorText = json['flavor_text'];
    language = json['language'] != null
        ?  NamedAPIResource.fromJson(json['language'])
        : null;
    versionGroup = json['version_group'] != null
        ?  NamedAPIResource.fromJson(json['version_group'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['flavor_text'] = flavorText;
    if (language != null) {
      data['language'] = language!.toJson();
    }
    if (versionGroup != null) {
      data['version_group'] = versionGroup!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'AbilityFlavorTextEntries{flavorText: $flavorText, language: $language, versionGroup: $versionGroup}';
  }
}

class AbilityPokemon {
  bool? isHidden;
  int? slot;
  AbilityPokemon? pokemon;

  AbilityPokemon({isHidden, slot, pokemon});

  AbilityPokemon.fromJson(Map<String, dynamic> json) {
    isHidden = json['is_hidden'];
    slot = json['slot'];
    pokemon = json['pokemon'] != null
        ?  AbilityPokemon.fromJson(json['pokemon'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['is_hidden'] = isHidden;
    data['slot'] = slot;
    if (pokemon != null) {
      data['pokemon'] = pokemon!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'AbilityPokemon{isHidden: $isHidden, slot: $slot, pokemon: $pokemon}';
  }
}
