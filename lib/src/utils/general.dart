

import 'package:flutter/material.dart';

String formatoCeros(int? numero) {
  // Utiliza la función toString para convertir el número a una cadena
  String numeroStr = numero.toString();

  // Calcula la cantidad de ceros necesarios
  int cantidadCeros = 3 - numeroStr.length;

  // Concatena los ceros necesarios a la cadena original
  String resultado = '0' * cantidadCeros + numeroStr;

  return resultado;
}


String officialImageURL(int? id){
return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
}

String officialShinyImageURL(int? id){
return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/$id.png';
}

Size tamano(BuildContext context){

  var size = MediaQuery.of(context).size;

  var w = size.width;
  var h = size.height;

  double nw = w;
  double nh = h;

  if(size.width > size.height){
    nw = h;
    nh = w;
  }

  return Size(nw, nh);
}