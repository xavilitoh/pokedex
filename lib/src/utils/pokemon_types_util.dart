

import 'package:flutter/material.dart';

import 'general.dart';

Color? cardColor ({String? type = '1' }){

  var color = switch (type) {
    '1' => Colors.blueGrey[400], //normal
    '2' => const Color(0xFFC22E28), //lucha
    '3' => const Color(0xFFA98FF3), //volador
    '4' => const Color(0xFFA33EA1), // veneno
    '5' => const Color(0xFFE2BF65), //tierra
    '6' => const Color(0xFFB6A136), //rock
    '7' => const Color(0xFFA6B91A), //bug
    '8' => const Color(0xFF735797), //ghost
    '9' => const Color(0xFFB7B7CE), //steel
    '10' => const Color.fromARGB(255, 238, 70, 48), //fire
    '11' => const Color(0xFF6390F0), //water
    '12' => const Color(0xFF7AC74C), //grass
    '13' => const Color(0xFFF7D02C), //electric
    '14' => const Color(0xFFF95587), //electric
    '15' => const Color(0xFF96D9D6), //ice
    '16' => const Color(0xFF6F35FC), //dragon
    '17' => const Color(0xFF705746), //dark
    '18' => const Color(0xFFD685AD), //fairy
    _ => Colors.grey[400], //Default value
  };

  return color;

} 

Color? typeColor ({dynamic type = '1' }){

  var color = switch (capitalizeFirstLetter(type)) {
    'Normal' => Colors.blueGrey[400], //normal
    'Fighting' => const Color(0xFFC22E28), //Fighting
    'Flying' => const Color(0xFFA98FF3), //volador
    'Poison' => const Color(0xFFA33EA1), // veneno
    'Ground' => const Color(0xFFE2BF65), //Ground
    'Rock' => const Color(0xFFB6A136), //rock
    'Bug' => const Color(0xFFA6B91A), //bug
    'Ghost' => const Color(0xFF735797), //ghost
    'Steel' => const Color(0xFFB7B7CE), //steel
    'Fire' => const Color(0xFFEE8130), //fire
    'Water' => const Color(0xFF6390F0), //water
    'Grass' => const Color(0xFF7AC74C), //grass
    'Electric' => const Color(0xFFF7D02C), //electric
    'Psychic' => const Color(0xFFF95587), //electric
    'Ice' => const Color(0xFF96D9D6), //ice
    'Dragon' => const Color(0xFF6F35FC), //dragon
    'Monster' => const Color(0xFF705746), //dark
    'Fairy' => const Color(0xFFD685AD), //fairy
    _ => Colors.grey[400], //Default value
  };

  return color;

} 

int typeId ({dynamic type = '1' }){

  var id = switch (capitalizeFirstLetter(type)) {
    'Normal' => 1, //normal
    'Fighting' => 2, //Fighting
    'Flying' => 3, //volador
    'Poison' => 4, // veneno
    'Ground' => 5, //Ground
    'Rock' => 6, //rock
    'Bug' => 7, //bug
    'Ghost' => 8, //ghost
    'Steel' => 9, //steel
    'Fire' => 10, //fire
    'Water' => 11, //water
    'Grass' => 12, //grass
    'Electric' => 13, //electric
    'Psychic' => 14, //electric
    'Ice' => 15, //ice
    'Dragon' => 16, //dragon
    'Monster' => 17, //dark
    'Fairy' => 18, //fairy
    _ => 1, //Default value
  };

  return id;
} 


String typeImage({String? type = '1' }){
  return 'assets/images/types/$type.png';
}