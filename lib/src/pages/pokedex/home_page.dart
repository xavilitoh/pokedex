


import 'package:flutter/material.dart';
import 'package:ladex/src/models/pokemon_b.dart';
import 'package:ladex/src/widgets/animated_ball.dart';

import '../../blocs/pokemon_bloc.dart';
import '../../delegates/search_delegate.dart';
import '../../utils/general.dart';
import '../../widgets/pokemon/pokemon_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  PokemonBloc pokebloc = PokemonBloc();
  int _cantidad = 2;
  final int _offset = 1;
  final int _limit = 20;
  final scrollController = ScrollController();
  late AnimationController _controller;

  Future<void> _refresh() {
    return pokebloc.getPokemones(offset: 1, limit: 20);
  }

  @override
  void initState() {
    super.initState();
    pokebloc.getPokemones(offset: _offset, limit: _limit);
    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent == scrollController.offset){
        // _offset = _limit * _counter + 1;
        // _counter++;

        // pokebloc.getPagesPokemones(offset: _offset, limit: _limit);
      }
    });

    _controller = AnimationController(
    vsync: this, duration: const Duration(milliseconds: 6000));
    _controller.repeat();
  }

  @override
  void dispose(){
    super.dispose();

    scrollController.dispose();
    _controller.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    if (fullWidth(context) <= 460) {
      // running on the web!
      _cantidad = 2;
    } else if(fullWidth(context) <= 860) {
      _cantidad = 4;
    }
    else{
      _cantidad = 6;
    }

    final size = tamano(context);
    return Scaffold(
      body: Stack(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        children: [
          Positioned(
              top: -(getDimention(context, 50)),
              right: - (size.height * 0.015),
              child: AnimatedBall(imageHeight: fullHeight(context) * 0.25, color: Colors.black26, controller: _controller,)
          ),
          Positioned(
            top: fullHeight(context) * 0.08,
            left: size.width * 0.08,
            child: SizedBox(
              width: fullWidth(context) - getDimention(context, 70),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(
                  'Pokedex',
                  style:  TextStyle(
                    fontSize: size.height * 0.04,
                    fontWeight: FontWeight.w900
                  ),
                ),
                IconButton(
                  onPressed: () => {
                    showSearch(
                      context: context, 
                      delegate: SearchPokemonDelegate())
                  }, 
                  icon: const Icon(Icons.search)
                )
                ]
              ),
            )
          ),
          Positioned(
            top: fullHeight(context) * 0.20,
            bottom: 0,
            width: fullWidth(context),
            child: StreamBuilder(
                stream: pokebloc.pokemones, 
                builder:(BuildContext context, AsyncSnapshot<List<PokemonB?>> snapshot){
            
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

  Widget _buildList(List<PokemonB?>? list, Size size) {
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