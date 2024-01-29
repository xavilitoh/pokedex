

import 'package:flutter/material.dart';
import 'package:ladex/src/blocs/pokemon_bloc.dart';
import 'package:ladex/src/models/pokemon_b.dart';

import '../blocs/bloc_provider.dart';
import '../utils/general.dart';
import '../widgets/pokemon/pokemon_card_widget.dart';

class SearchPokemonDelegate extends SearchDelegate{

  @override
  String get searchFieldLabel => 'Buscar pokemon';
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {

    final bloc = BlocProvider.of(context)?.pokemonBloc;

    bloc?.searchPokemones(query);
    return _searchResut(bloc, context);
  }

  Scaffold _searchResut(PokemonBloc? bloc, BuildContext context) {

    int cantidad = 2;

    if (fullWidth(context) <= 460) {
      // running on the web!
      cantidad = 2;
    } else if(fullWidth(context) <= 860) {
      cantidad = 4;
    }
    else{
      cantidad = 6;
    }
    
    return Scaffold(
    body: StreamBuilder<List<PokemonB?>>(
      stream: bloc?.pokemonesSearch,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cantidad,
            ), 
            itemBuilder: (context, index){
              if(index < (snapshot.data?.length?? 0)){
                var item = snapshot.data?[index];
                return PokemonCard(pokemon: item,);
              }else {
                return null;
              }
            }
          );
        }else{
          return Container();
        }
      },
    ),
  );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    final bloc = BlocProvider.of(context)?.pokemonBloc;

    bloc?.searchPokemones(query);
    return _searchResut(bloc, context);
  }

}