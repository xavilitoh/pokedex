

// ignore_for_file: deprecated_member_use

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
  return 'assets/images/$id.png';
}

// ignore: non_constant_identifier_names
String ImageURL(String? id){
  return 'assets/images/$id.png';
}

String officialShinyImageURL(int? id){
  return 'assets/images/variocolor/$id.png';
}

String pokeAminated(int? id){
  return 'assets/images/animado/$id.gif';
}

String pokeShinyAminated(int? id){
  return 'assets/images/animado/variocolor/$id.gif';
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

Widget customText(String msg, {TextStyle? style,TextAlign textAlign = TextAlign.justify,overflow = TextOverflow.clip,BuildContext? context}){

  if(context != null && style != null){
    var fontSize = style.fontSize ?? 10;
    style =  style.copyWith(fontSize: fontSize - ( fullWidth(context) <= 375  ? 2 : 0));
  }
  return Text(msg,style: style,textAlign: textAlign,overflow:overflow,);
}

double fullWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
} 

double fullHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
} 

double getDimention(context, double unit){
  if(fullWidth(context) <= 860.0){
    return unit / 1.3;
  }else if(fullWidth(context) <= 1500){
    return unit / 1;
  }
  else {
    return unit / 0.7;
  }
}

double getFontSize(BuildContext context,double size){
  if(MediaQuery.of(context).textScaleFactor < 1){
    return getDimention(context,size);
  }
  else{
    return getDimention(context,size / MediaQuery.of(context).textScaleFactor);
  }
}

String capitalizeFirstLetter(String input) {
  if (input.isEmpty) {
    return input;
  }
  return input[0].toUpperCase() + input.substring(1);
}