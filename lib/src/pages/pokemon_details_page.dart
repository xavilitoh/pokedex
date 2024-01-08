

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ladex/src/widgets/pokemon/type_badge_widget.dart';

import 'package:pokeapi/model/pokemon/pokemon.dart';

import '../utils/pokemon_types_util.dart';

class PokemonDetailPage extends StatefulWidget {
  const PokemonDetailPage({Key? key}) : super(key: key);
  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  @override
  Widget build(BuildContext context) {

    var pokemon = ModalRoute.of(context)?.settings.arguments as Pokemon;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: cardColor(type: pokemon.types?[0].type?.id),
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        backgroundColor: cardColor(type: pokemon.types?[0].type?.id),
        title: Text(
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: size.height * 0.030,
                      overflow: TextOverflow.ellipsis
                    ),
                    pokemon.name?.toUpperCase()?? ''),
      ),
      body: Stack(
        children: [
          Positioned(
            top: - (size.height * 0.001),
            right: - (size.height * 0.015),
            child: Image.asset('assets/images/pokeball.png', height: size.height * 0.25, fit: BoxFit.fill)
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: size.width,
              height: size.height * 0.7,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),                
              color: Colors.white,
              ),
              child: _detailBox(size, pokemon),
            ),
          ),
          Positioned(
            top: size.height * 0.03,
            left: 10,
            child: SizedBox(
              width: size.width * 0.5,
              height: size.height * 0.1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: _tipos(pokemon.types, size),
              ),
            )
          ),
          Positioned(
                top: (size.height * 0.02),
                right: size.width * 0.02,
                child: Hero(
                  tag: pokemon.name?? '',
                  child: CachedNetworkImage(
                    imageUrl: pokemon.sprites?.frontDefault?? '',
                    height: size.height * 0.2,
                    fit: BoxFit.fitHeight,                        
                  ),
                ),
          ),
        ],
      ),
    );
  }
  
  List<Widget> _tipos(List<Types>? types, Size size) {

    var list =List<Widget>.empty(growable: true);
    types?.forEach((element) {
      list.add(Padding(
        padding:  EdgeInsets.symmetric(horizontal: size.width * 0.01),
        child: TypeBadge(type: element),
      ));
    });

    return list;
  }
  
  _detailBox(Size size, Pokemon pokemon) {
    return Container(
      margin: EdgeInsets.only(right: size.width * 0.1, left: size.width * 0.1, top: size.width * 0.1),
      child: Column(
        children: [
          Center(
            child: Text(
                'Info. General',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: size.width * 0.058,
                  fontWeight: FontWeight.w900,
                ),
              ),
          ),
          const SizedBox(
            height: 20,
          ),
          _name(size, pokemon),
          _number(size, pokemon),
          _height(size, pokemon),
          _weight(size, pokemon),
          const SizedBox(
            height: 20,
          ),
                    Center(
            child: Text(
                'Estadisticas',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: size.width * 0.058,
                  fontWeight: FontWeight.w900,
                ),
              ),
          ),
          const SizedBox(
            height: 20,
          ),
          _stats(size, pokemon),
        ],
      ),
    );
  }

  Row _name(Size size, Pokemon pokemon) {
    return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                'Nombre',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: size.width * 0.05,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Container(
              child: Text(
                pokemon.name?? '',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: size.width * 0.05
                ),
              ),
            )
          ],
        );
  }

  Row _number(Size size, Pokemon pokemon) {
    return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                'Numero',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: size.width * 0.05,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Container(
              child: Text(
                pokemon.id.toString()?? '',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: size.width * 0.05
                ),
              ),
            )
          ],
        );
  }

  Row _height(Size size, Pokemon pokemon) {
    return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                'Altura',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: size.width * 0.05,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Container(
              child: Text(
                '${pokemon.height} m',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: size.width * 0.05
                ),
              ),
            )
          ],
        );
  }

  Row _weight(Size size, Pokemon pokemon) {
    return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                'Peso',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: size.width * 0.05,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Container(
              child: Text(
                '${pokemon.weight} Kg',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: size.width * 0.05
                ),
              ),
            )
          ],
        );
  }

  _stats(Size size, Pokemon pokemon){

    var list = pokemon.stats;
    var widgetsList = List<Widget>.empty(growable: true);

    list?.forEach((element) {
      widgetsList.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                element.stat?.name?? '',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: size.width * 0.05,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                element.baseStat.toString()?? '',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: size.width * 0.05,
                  fontWeight: FontWeight.w900,
                ),
              )
          ],
        )
      );
    });

    return Column(
      children: widgetsList,
    );
  }
}