


import 'package:flutter/material.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

import '../blocs/pokemon_bloc.dart';
import '../utils/general.dart';
import '../widgets/pokemon/pokemon_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PokemonBloc pokebloc = PokemonBloc();
  int _cantidad = 2;
  int _offset = 1;
  int _counter = 1;
  final int _limit = 20;
  final scrollController = ScrollController();

  Future<void> _refresh() {
    return pokebloc.getPokemones(offset: 1, limit: 20);
  }

  @override
  void initState(){
    super.initState();
    pokebloc.getPokemones(offset: _offset, limit: _limit);
    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent == scrollController.offset){
        _offset = _limit * _counter + 1;
        _counter++;

        pokebloc.getPagesPokemones(offset: _offset, limit: _limit);
      }
    });
  }

  @override
  void dispose(){
    super.dispose();

    scrollController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    if (kIsWeb) {
      // running on the web!
      _cantidad = 2;
    } else {
          // Se verifica la plataforma.
      if(Platform.isAndroid || Platform.isIOS){
        _cantidad = 2;
      }else{
        _cantidad = 3;
      }
    }

    final size = tamano(context);
    return Scaffold(
      body: Stack(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        children: [
          Positioned(
              top: -(size.height * 0.02),
              right: - (size.height * 0.015),
              child: Image.asset('assets/images/pokeball.png', height: size.height * 0.25, fit: BoxFit.fill)
          ),
          Positioned(
            top: size.height * 0.12,
            left: size.width * 0.08,
            child: Text(
              'Pokedex',
              style:  TextStyle(
                fontSize: size.height * 0.04,
                fontWeight: FontWeight.w900
              ),
            )
          ),
          Positioned(
            top: size.height * 0.20,
            bottom: 0,
            width: size.width,
            child: StreamBuilder(
                stream: pokebloc.pokemones, 
                builder:(BuildContext context, AsyncSnapshot<List<Pokemon?>> snapshot){
            
                  if(snapshot.hasData){
                    return _buildList(snapshot.data, size);
                  }else{
                    return Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
                        child: const CircularProgressIndicator()
                      ),
                    );
                  }
                }
            ),
          ) , // This trailing comma makes auto-formatting nicer for build methods.
        ]
    )
    );
  }

  Widget _buildList(List<Pokemon?>? list, Size size) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.035),
      child: RefreshIndicator(
        onRefresh: () => _refresh(),
        displacement: 50,
        child: GridView.builder(
          controller: scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _cantidad,
          ), 
          itemBuilder: (context, index){
            if(index < (list?.length?? 0)){
                var item = list?[index];
              return PokemonCard(pokemon: item,);
            }else {
              return null;
            }
          }
        ),
      ),
    );
  }

}