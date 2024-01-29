
import 'package:flutter/material.dart';
import 'package:ladex/src/models/pokemon_b.dart';

import '../../utils/general.dart';  
import '../../utils/pokemon_types_util.dart';
import 'type_badge_widget.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({
    super.key,
    required this.pokemon
  });

  final PokemonB? pokemon;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      hoverColor: Colors.transparent,
      onTap: () async {
        Navigator.pushNamed(context, 'pk_details', arguments: pokemon);
      },
      child: Card(
        color: typeColor(type: pokemon?.typeofpokemon?[0]),
        child: SizedBox(
          height: fullHeight(context) * 0.3,
          child: Stack(
            children: [
              Positioned(
                top: getDimention(context, 55),
                left: getDimention(context, 70),
                child: Image.asset('assets/images/pokeball.png', height: getDimention(context, 150), fit: BoxFit.fill)
              ),
              Positioned(
                top: 20,
                left: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: getFontSize(context, 18),
                        overflow: TextOverflow.clip
                      ),
                      pokemon?.name?.toUpperCase()?? ''),
                      TypeBadge(type: pokemon?.typeofpokemon?[0], onlyImage: true,)
                  ],
                )),
              Positioned(
                top: getDimention(context, 50),
                left: getDimention(context, 70),
                child: Hero(
                  tag:  pokemon?.name?? '',
                  child: Image.asset(
                    officialImageURL(int.parse(pokemon?.id?.replaceAll('#', '')?? '0')),
                    height: getDimention(context, 150),
                    fit: BoxFit.contain,
                        
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

