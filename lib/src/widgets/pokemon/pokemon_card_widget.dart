

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';

import '../../utils/general.dart';
import '../../utils/pokemon_types_util.dart';
import 'type_badge_widget.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({
    super.key,
    required this.pokemon
  });

  final Pokemon? pokemon;

  @override
  Widget build(BuildContext context) {

    final size = tamano(context);

    return InkWell(
      onTap: () => {
        //navigate to pokemon details page
        Navigator.pushNamed(context, 'pk_details', arguments: pokemon)
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: size.height * 0.01, horizontal: size.width * 0.015),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: cardColor(type: pokemon?.types?[0].type?.id),
        ),
        child: SizedBox(
          height: size.height * 0.8,
          child: Stack(
            children: [
              Positioned(
                bottom: - (size.height * 0.03),
                right: - (size.height * 0.015),
                child: Image.asset('assets/images/pokeball.png', height: size.height * 0.15, fit: BoxFit.fill)
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
                        fontSize: size.height * 0.020,
                        overflow: TextOverflow.clip
                      ),
                      pokemon?.name?.toUpperCase()?? ''),
                      TypeBadge(type: pokemon?.types?[0])
                  ],
                )),
              Positioned(
                bottom: - (size.height * 0.02),
                right: - (size.width * 0.02),
                child: Hero(
                  tag:  pokemon?.name?? '',
                  child: CachedNetworkImage(
                    imageUrl: officialImageURL(pokemon?.id),
                    height: size.height * 0.15,
                    width: size.height * 0.15,
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

