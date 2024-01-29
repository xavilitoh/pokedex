
import 'package:flutter/material.dart';
import 'package:ladex/src/blocs/pokemon_bloc.dart';

class BlocProvider extends InheritedWidget {
  static BlocProvider? _instance;

  final pokemonBloc = PokemonBloc();

  factory BlocProvider({ Key? key, Widget? child}) {
    child ??= Container();
    return _instance?? BlocProvider._(key: key,child: child,);
  }

  BlocProvider._({ Key? key,  required child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static BlocProvider? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<BlocProvider>();
}
