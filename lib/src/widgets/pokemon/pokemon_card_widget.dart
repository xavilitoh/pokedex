

// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ladex/src/models/pokemon_b.dart';
// import 'package:pokeapi/model/pokemon/pokemon.dart';

import '../../blocs/bloc_provider.dart';
import '../../models/pokemon.dart';
import '../../services/poke_Api.dart';
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
    
    BlocProvider? pokebloc = BlocProvider.of(context);

    return InkWell(
      hoverColor: Colors.transparent,
      onTap: () async {
        
         PokeAPI.getObject<Species>(int.parse(pokemon?.id?.replaceAll('#', '')?? '0')).then((value) => pokemon?.ydescription =value?.flavorTextEntry?.replaceAll(RegExp(r'\n'), ' ')?? '');
        pokebloc?.pokemonBloc.setPokemon(pokemon);

        // navigate to pokemon details page
        Navigator.pushNamed(context, 'pk_details', arguments: pokemon);
      },
      child: Container(
        height: fullHeight(context) * 0.3,
        width: getDimention(context, 20),
        margin: EdgeInsets.symmetric(vertical: fullHeight(context) * 0.01, horizontal:getFontSize(context, 10)),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: typeColor(type: pokemon?.typeofpokemon?[0])
        ),
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
                  child: CachedNetworkImage(
                    imageUrl: officialImageURL(int.parse(pokemon?.id?.replaceAll('#', '')?? '0')),
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

