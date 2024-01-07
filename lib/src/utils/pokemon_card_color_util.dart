

import 'package:flutter/material.dart';

Color? cardColor ({String? type = '1' }){

  var color = switch (type) {
    '1' => Colors.grey[400], //normal
    '2' => const Color(0xFFC22E28), //lucha
    '3' => const Color(0xFFA98FF3), //volador
    '4' => const Color(0xFFA33EA1), // veneno
    '5' => const Color(0xFFE2BF65), //tierra
    '6' => const Color(0xFFB6A136), //rock
    '7' => const Color(0xFFA6B91A), //bug
    '8' => const Color(0xFF735797), //ghost
    '9' => const Color(0xFFB7B7CE), //steel
    '10' => const Color(0xFFEE8130), //fire
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