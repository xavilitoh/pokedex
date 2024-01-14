

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
    // TODO: implement buildActions
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: () => this.query = '')
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () => this.close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {

    final bloc = BlocProvider.of(context)?.pokemonBloc;

    bloc?.searchPokemones(query);

    // TODO: implement buildResults
    return _searchResut(bloc, context);
  }

  Scaffold _searchResut(PokemonBloc? bloc, BuildContext context) {

    int _cantidad = 2;

    if (fullWidth(context) <= 460) {
      // running on the web!
      _cantidad = 2;
    } else if(fullWidth(context) <= 860) {
      _cantidad = 4;
    }
    else{
      _cantidad = 6;
    }
    
    return Scaffold(
    body: StreamBuilder<List<PokemonB?>>(
      stream: bloc?.pokemonesSearch,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _cantidad,
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
    // TODO: implement buildSuggestions
    return _searchResut(bloc, context);
  }

}