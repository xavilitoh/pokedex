

import 'package:flutter/material.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';

import '../../utils/pokemon_types_util.dart';

class TypeBadge extends StatelessWidget {
  const TypeBadge({
    super.key,
    required this.type,
  });

  final Types? type;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.045,
      decoration: const BoxDecoration(                
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
        child: Row(
          children: [
            Image.asset(typeImage(type:  type?.type?.id)),
            Text(
              style: TextStyle(
                color: cardColor(type: type?.type?.id),
                fontSize: size.height * 0.025
              ),
              type?.type?.name?? ''),
          ],
        ),
      ),
    );
  }
}