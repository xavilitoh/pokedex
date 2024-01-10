

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ladex/src/widgets/pokemon/type_badge_widget.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'package:pokeapi/model/pokemon/pokemon.dart';
import 'package:pokeapi/pokeapi.dart';

import '../utils/general.dart';
import '../utils/pokemon_types_util.dart';

class PokemonDetailPage extends StatefulWidget {
  const PokemonDetailPage({Key? key}) : super(key: key);
  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  
  int selectedIndex = 0;
  String? desc = '';
  @override
  Widget build(BuildContext context) {

    var pokemon = ModalRoute.of(context)?.settings.arguments as Pokemon;
    final size = tamano(context);

    PokeAPI.getObject<Species>(pokemon.id?? 0).then((value) => setState(() {
      desc = value?.flavorTextEntry?.replaceAll(RegExp(r'\n'), ' ')?? '';
    },));
    

    return Scaffold(
      backgroundColor: cardColor(type: pokemon.types?[0].type?.id),
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        backgroundColor: cardColor(type: pokemon.types?[0].type?.id),
        // title: Text(
        //             style: TextStyle(
        //               fontWeight: FontWeight.bold,
        //               color: Colors.white,
        //               fontSize: size.height * 0.030,
        //               overflow: TextOverflow.ellipsis
        //             ),
        //             pokemon.name?.toUpperCase()?? ''),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: cardColor(type: pokemon.types?[0].type?.id),
        type: BottomNavigationBarType.shifting,
        currentIndex: selectedIndex,
        onTap: (value) => {
          setState((){
            selectedIndex = value;
          })
        },
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.info_outline,
              color: cardColor(type: pokemon.types?[0].type?.id),
            ),
            activeIcon: Icon(Icons.info,
              color: cardColor(type: pokemon.types?[0].type?.id),
            ),
            label: 'informacion',
            backgroundColor: Colors.white
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border_outlined,
              color: cardColor(type: pokemon.types?[0].type?.id),
            ),
            activeIcon: Icon(Icons.star_border_rounded,
              color: cardColor(type: pokemon.types?[0].type?.id),
            ),
            label: 'Variocolor',
            backgroundColor: Colors.white,
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: size.height * 0.16,
            right: - (size.height * 0.015),
            child: Image.asset(
              'assets/images/pokeball.png', 
              height: size.height * 0.25, 
              fit: BoxFit.fill,
              alignment: Alignment.center,
            )
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: size.width,
              height: size.height * 0.48,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20),),                
              color: Colors.white,
              ),
              child: _scroll(size, pokemon),
            ),
          ),
          Positioned(
            top: - size.height * 0.0001,
            left: 20,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: size.height * 0.04,
                        overflow: TextOverflow.ellipsis
                      ),
                      pokemon.name?.toUpperCase()?? ''),
                  SizedBox(
                    width: size.width,
                    height: size.height * 0.05,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: _tipos(pokemon.types, size),
                    )
                  ),
                  const SizedBox(
                    height: 20,
                  ),                _number(size, pokemon),
                  _height(size, pokemon),
                  _weight(size, pokemon)
                ],
              ),
            )
          ),
          Positioned(
                top: (size.height * 0.1),
                right: size.width * 0.1,
                child: Hero(
                  tag: pokemon.name?? '',
                  child: CachedNetworkImage(
                    alignment: Alignment.topRight,
                    imageUrl: officialImageURL(pokemon.id),
                    height: size.height * 0.3,
                    fit: BoxFit.fitHeight,                        
                  ),
                ),
          ),
        ],
      ),
    );
  }

  List<Widget> _screens(Size size, Pokemon pokemon){
    return [_info(size, pokemon), _varioColor(size, pokemon)];
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

  Widget _varioColor(Size size, Pokemon pokemon){
    return Container(
      margin: EdgeInsets.only(right: size.width * 0.1, left: size.width * 0.1),
      child: Column(
        children: [
          Center(
            child: Text(
                'Variocolor',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: size.height * 0.037,
                  fontWeight: FontWeight.w900,
                ),
              ),
          ),
          const SizedBox(
            height: 20,
          ),
          CachedNetworkImage(
                    imageUrl: officialShinyImageURL(pokemon.id),
                    height: size.height * 0.3,
                    fit: BoxFit.fitHeight,                        
          ),
        ],
      ),
    );
  }

  _scroll(Size size, Pokemon pokemon){
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          child: IndexedStack(
            index: selectedIndex,
            children: _screens(size, pokemon),
          ),
        );
      },
    );
  }

  Widget _info(Size size, Pokemon pokemon){
    return Container(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          _stats(size, pokemon)
        ],
      ),
    );
  }

  Widget _stats(Size size, Pokemon pokemon){
    return Container(
      margin: EdgeInsets.only(right: size.width * 0.1, left: size.width * 0.1),
      child: Column(
        children: [
            Center(
              child: Text(
              desc?? '',
              style: TextStyle(
                color: Colors.grey,
                fontSize: size.height * 0.015,
              ),
              textAlign: TextAlign.center,
            ),
            ),
                      const SizedBox(
            height: 20,
          ),
            Text(
              'Estadisticas',
              style: TextStyle(
                color: Colors.grey,
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.w900,
              ),
            ),
          const SizedBox(
            height: 20,
          ),
          _statsList(size, pokemon),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Row _number(Size size, Pokemon pokemon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
         Text(
          '#',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size.height * 0.02
                ),
        ),
        Text(
          formatoCeros(pokemon.order),
          
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size.height * 0.02
                ),
        ),
      ],
    );
  }

  Row _height(Size size, Pokemon pokemon) {
    return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Container(
            //   child: Text(
            //     '📏',
            //     style: TextStyle(
            //       color: Colors.grey,
            //       fontSize: size.width * 0.05,
            //     ),
            //   ),
            // ),
            Text(
              '${pokemon.height} m',
              style: TextStyle(
                color: Colors.white,
                fontSize: size.height * 0.02
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
            // Text(
            //   '⚖️',
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: size.width * 0.05,
            //   ),
            // ),
            Text(
              '${pokemon.weight} Kg',
              style: TextStyle(
                color: Colors.white,
                fontSize: size.height * 0.02
              ),
            )
          ],
        );
  }

  _statsList(Size size, Pokemon pokemon){

    var list = pokemon.stats;
    var widgetsList = List<Widget>.empty(growable: true);

    list?.forEach((element) {
      widgetsList.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: size.width * 0.3,
              child: Text(
                  element.stat?.name?? '',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: size.height * 0.015,
                    overflow: TextOverflow.ellipsis
                  ),
                ),
            ),
            Center(
              child: Text(
                  element.baseStat.toString(),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: size.height * 0.015,
                    overflow: TextOverflow.ellipsis
                  ),
                ),
            ),
            Center(
              heightFactor: 5,
              child: LinearPercentIndicator(
                  width: size.width * 0.4,
                  animation: true,
                  lineHeight: 3.0,
                  animationDuration: 2000,
                  percent: ((element.baseStat?? 1) / 200).toDouble(),
                  barRadius: const Radius.circular(20),
                  progressColor: cardColor(type: pokemon.types?[0].type?.id),
                  backgroundColor: Colors.grey[300],
                ),
            ),
              // Container(
              //   width: size.width * 0.4,
              //   child: LinearProgressIndicator(
              //     minHeight: 15,
              //     backgroundColor: Colors.grey[300],
              //     color: cardColor(type: pokemon.types?[0].type?.id),
              //     value: ((element.baseStat?? 1) / 200).toDouble(),
              //     semanticsLabel: element.baseStat.toString(),
              //   ),
              // )
              // Text(
              //   element.baseStat.toString()?? '',
              //   style: TextStyle(
              //     color: cardColor(type: pokemon.types?[0].type?.id),
              //     fontSize: size.width * 0.05,
              //   ),
              // )
          ],
        )
      );
      widgetsList.add(const SizedBox(
            height: 10,
          ));
    });

    return Column(
      children: widgetsList,
    );
  }
}