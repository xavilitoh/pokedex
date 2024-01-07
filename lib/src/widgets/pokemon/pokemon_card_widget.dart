

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';

import '../../utils/pokemon_card_color_util.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({
    super.key,
    required this.pokemon
  });

  final Pokemon? pokemon;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
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
              child: Text(
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18
                ),
                pokemon?.name?.toUpperCase()?? '')),
            Positioned(
              top: 50,
              left: 10,
              child: Container(
                decoration: const BoxDecoration(                
                  color: Colors.white10,
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                  child: Text(
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    pokemon?.types?[0].type?.name?? ''),
                ),
              )
            ),
            Positioned(
              bottom: - (size.height * 0.02),
              right: - (size.width * 0.02),
              child: CachedNetworkImage(
                imageUrl: pokemon?.sprites?.frontDefault?? '',
                height: size.height * 0.15,
                fit: BoxFit.fitHeight,
    
              ),
            ),
          ],
        ),
      ),
    );
  }
}