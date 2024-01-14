
import 'package:flutter/material.dart';
import 'package:ladex/src/blocs/pokemon_bloc.dart';

class BlocProvider extends InheritedWidget {
  static BlocProvider? _instance;

  final pokemonBloc = PokemonBloc();

  factory BlocProvider({ Key? key, Widget? child}) {
    if(child == null) child = Container();
    return _instance?? BlocProvider._(child: child, key: key,);
  }

  BlocProvider._({ Key? key,  required child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static BlocProvider? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<BlocProvider>();
}
