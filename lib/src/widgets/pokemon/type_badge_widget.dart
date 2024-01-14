

import 'package:flutter/material.dart';
// import 'package:pokeapi/model/pokemon/pokemon.dart';

import '../../utils/general.dart';
import '../../utils/pokemon_types_util.dart';

class TypeBadge extends StatelessWidget {
  const TypeBadge({
    super.key,
    required this.type,
    this.onlyImage = false,
    this.moderno = false
  });

  final String type;
  final bool? onlyImage;
  final bool moderno;

  @override
  Widget build(BuildContext context) {

    return Container(
      height: getFontSize(context, 50),
      decoration: const BoxDecoration(                
        color: Colors.white54,
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
        child: Row(
          children: [
            Image.asset(typeImage(type: moderno? type : typeId(type: type).toString()), height: getFontSize(context, 50),),
            onlyImage == false? Text(
              style: TextStyle(
                color: typeColor(type: type),
                fontSize: getFontSize(context, 18)
              ),
              type?? '') : Container(),
          ],
        ),
      ),
    );
  }
}