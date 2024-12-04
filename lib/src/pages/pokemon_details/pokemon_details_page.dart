
import 'package:flutter/material.dart';
import 'package:ladex/src/models/pokemon_b.dart';
import 'package:ladex/src/widgets/pokemon/type_badge_widget.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../blocs/bloc_provider.dart';
import '../../delegates/search_delegate.dart';
import '../../providers/pokemos/pokemon_search_provider.dart';
import '../../utils/general.dart';
import '../../utils/pokemon_types_util.dart';
import '../../widgets/animated_ball.dart';
import '../../widgets/card_widget.dart';

class PokemonDetailPage extends StatefulWidget  {
  const PokemonDetailPage({super.key});
  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> with TickerProviderStateMixin {
  
  int selectedIndex = 0;
  String? desc = '';
  
  double opacity = 0;
  int pokeID = 0;
  double divider = 100;
  BlocProvider? pokebloc;
  PokemonB pokemon = PokemonB();
  late AnimationController _controller;
  final _panelController = PanelController();
  late final ScrollController _scrollController = ScrollController();
  late TabController _tabController;
  late Color color;

  late List<Widget> _tabs = [];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
    vsync: this, duration: const Duration(milliseconds: 10000));
    _controller.repeat();
    
    _scrollController.addListener(_onScrollEvent);

    _tabController = TabController(length: 3, vsync: this, initialIndex: selectedIndex);
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  void _onScrollEvent() {
    final extentAfter = _scrollController.position.extentAfter;

    if(extentAfter > 0){
      _panelController.animatePanelToPosition(0);
    }else{
      _panelController.animatePanelToPosition(1);
    }
  }

  void setDivider(int total){
    if(total> 100 && total < 200) {
      divider = 200;
    } else if(total > 200 && total < 300) {divider = 300;}
    else if(total > 300 && total < 400) {divider = 400;}
    else if(total > 400 && total < 500) {divider = 500;}
    else if(total > 500 && total < 600) {divider = 600;}
    else if(total > 600 && total < 700) {divider = 700;}
    else if(total > 700 && total < 800) {divider = 800;}
    else if(total > 800 && total < 900) {divider = 900;}
    else if(total > 900) {divider = 1000;}
  }

  Future changePokemon(int id) async {
      var response = await PokemonSearchProvider.readJsonFile();

      setState(() {
        pokemon = response.firstWhere((element) => int.parse(element.id?? '0') == id);
      });
  }

  @override
  Widget build(BuildContext context) {

    color = Theme.of(context).colorScheme.surface;

    _tabs = [
              Tab( child: Text('General',style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w900,fontSize: getFontSize(context, 13)),),),
              Tab(child: Text('Estadisticas',style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w900,fontSize: getFontSize(context, 13)),),),
              Tab(child: Text('Evoluciones',style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w900,fontSize: getFontSize(context, 13)),),)
            ];

    if(pokemon.name == null){
      pokemon = ModalRoute.of(context)?.settings.arguments as PokemonB;
    }
    
    desc =  pokemon.xdescription??  "${pokemon.ydescription}";

    pokeID = int.parse(pokemon.id?? '0');
    
    final size = tamano(context);

    pokebloc = BlocProvider.of(context);
    pokebloc?.pokemonBloc.evoluciones(pokemon.evolutions);
    
    setState(() {
      setDivider(pokemon.total?? 600);
    });    

    return Scaffold(
      appBar: opacity > 0.87? AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        actions: [
          _likeBTN()
        ],
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () async
              {
                await changePokemon((pokeID - 1));
              }, 
              icon: const Icon(Icons.arrow_back_ios_new_outlined)),
            Text(
                      pokemon.name?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: getFontSize(context, 20)
                      ),
                    ),
            IconButton(
              onPressed: () async
              {
                await changePokemon((pokeID + 1));
              }, 
              icon: const Icon(Icons.arrow_forward_ios_outlined)),
          ],
        ),
      ) : null ,
      backgroundColor: typeColor(type: pokemon.typeofpokemon?[0]),
      body: _details(context, pokemon, size)    
    );
  }

  Stack _details(BuildContext context, PokemonB? pokemon, Size size) {
    var backgroundColor = Theme.of(context).colorScheme.surface;
    return Stack(
      children: [
        Positioned(
          bottom: fullHeight(context) * 0.58,
          right: 50,
          left: 50,
          child: Align(
            heightFactor: getDimention(context,0.75),
            widthFactor: .7,
            child: AnimatedBall(opacity: opacity, imageHeight: getDimention(context,250), controller: _controller, color: Theme.of(context).colorScheme.surface,),
          )
        ),
        Positioned(
          top: getDimention(context,60),
          left: fullWidth(context) / 2 + 10,
          child: Image.asset(
            'assets/images/dotted.png', 
            height: fullHeight(context) * 0.03, 
            fit: BoxFit.fill,
            alignment: Alignment.center,
            color: Theme.of(context).colorScheme.surface,
          )
        ),
        Positioned(
          top: fullHeight(context) * 0,
          left: 20,
          child: Opacity(
            opacity: _invertirOpacity(),
            child: SafeArea(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: fullWidth(context) * 0.9,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon:  Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.surface,),
                          ),
                          _likeBTN(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ), 
                    SizedBox(
                        width: fullWidth(context) * 0.9,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.surface,
                                  fontSize: getFontSize(context, 32),
                                  overflow: TextOverflow.ellipsis
                                ),
                                pokemon?.name?.toUpperCase()?? ''),                
                            _number(size, pokemon),
                          ],
                        ),
                      ),
                    SizedBox(
                        width: fullWidth(context),
                        height: fullHeight(context) * 0.05,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: _tipos(pokemon?.typeofpokemon, size),
                        )
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          )
        ),
        Positioned(
          bottom: 0,
          child: Container(
            height: fullHeight(context) * 0.0,
            width: fullWidth(context),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20) ),
              color: backgroundColor
            ),            
          ),
        ),
        Positioned(
              bottom: fullHeight(context) * 0.58,
              right: 50,
              left: 50,
              child: SizedBox(
                width: fullWidth(context),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                     onPressed: () async
                      {
                        await changePokemon((pokeID - 1));
                      },
                      icon: Icon(
                         Icons.arrow_back_ios_outlined,
                         color: Theme.of(context).colorScheme.surface,
                         size: getFontSize(context, 40),
                        )
                      ),
                    Hero(
                      tag: pokemon?.name?? '',
                      child: Align(
                        heightFactor: getDimention(context,0.75),
                        widthFactor: .7,
                        child: Opacity(
                          opacity: _invertirOpacity(),
                          child: Image.asset(
                            officialImageURL(int.parse(pokemon?.id?.replaceAll('#', '')?? '0')),
                            height: getDimention(context,200),
                            fit: BoxFit.fitHeight,                        
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async
                      {
                        await changePokemon((pokeID + 1));
                      },
                      icon: Icon(
                         Icons.arrow_forward_ios_outlined,
                         color: Theme.of(context).colorScheme.surface,
                         size: getFontSize(context, 40),
                        )
                      ),
                  ],
                ),
              ),
        ),
        SlidingUpPanel(
          controller: _panelController,
          header: Center(
            child: SizedBox(
              height: 20,
              width: fullWidth(context),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: getDimention(context, 500)),
                margin: EdgeInsets.symmetric(horizontal: fullWidth(context) * 0.45, vertical: 6),
                height: 5,
                width: 5,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
              )
            )
          ),
          minHeight: fullHeight(context) * 0.55,
          maxHeight: fullHeight(context) * 0.95,
          boxShadow: const [CustomBoxShadow(
                color: Colors.black,
                offset:  Offset(10.0, 10.0),
                blurRadius: 0.0,
                blurStyle: BlurStyle.outer
            )],
          onPanelSlide: (slide) {
            setState(() {
              opacity = slide;
            });
          },
          borderRadius: opacity < 0.87? const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)) : null,
          panel: Container(
            width: fullWidth(context),
            decoration: BoxDecoration(
              borderRadius: opacity < 0.87? const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)
                ) : null,
              color: backgroundColor
            ),
            child: Padding(
                padding: EdgeInsets.only(top: fullHeight(context) * 0.04, bottom: fullHeight(context) * 0.12,),
                child: Scaffold(
                  backgroundColor: backgroundColor,
                  appBar: TabBar(
                    controller: _tabController,
                    indicatorColor: typeColor(type: pokemon?.typeofpokemon?[0]),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black54,
                    indicatorPadding: EdgeInsets.symmetric(horizontal: getDimention(context, 10)),
                    dividerColor: Colors.transparent,
                    tabs:  _tabs,
                  ),
                  body: TabBarView(
                    controller: _tabController,
                    children: [
                      DraggableScrollableSheet(
                        initialChildSize: 0.95,
                        builder: (context, scrollController){
                          return SingleChildScrollView(
                            controller: _scrollController,
                            child: _info(context, pokemon),
                          );
                        },
                      ),
                      DraggableScrollableSheet(
                        initialChildSize: 0.95,
                        builder: (context, scrollController){
                          return SingleChildScrollView(
                            child: 
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: getDimention(context, 50)),
                                child: _stats(pokemon)
                              ),
                          );
                        },
                      ),
                      DraggableScrollableSheet(
                        initialChildSize: 0.95,
                        builder: (context, scrollController){
                          return _evoluciones(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
          ),
        ),
        
      ],
    );
  }

  Widget _evoluciones(BuildContext context) {
    return StreamBuilder(
              stream: pokebloc?.pokemonBloc.lineaEvolutiva,
              builder: (context, snapshot) {

                if (snapshot.hasData) {
                  return SingleChildScrollView(
                      child: 
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: getDimention(context, 0)),
                          child: Column(
                            children: _evolsDetails(snapshot.data),
                          )
                        ),
                    );
                }else{
                return Container();
                }
              },
            );
  }

  _evolsDetails(List<PokemonB?>? list){

    List<Widget> l = [];
    list?.forEach((element) { 

      l.add(ListTile(
        title: Text(element?.name?? ""),
        leading: Image.asset(pokeAminated(
          int.parse(element?.id?.replaceAll('#', '')?? '0')), 
          errorBuilder: (context, error, stackTrace) {
            return  Image.asset( 
              officialImageURL(int.parse(pokemon.id?.replaceAll('#', '')?? '0')),
              width: getFontSize(context, 150),
              errorBuilder: (context, error, stackTrace) {
                return  Image.asset( 'assets/images/pokeball.gif');
              },                    
            );
          },
          width: getDimention(context, 100)),
        subtitle: Text("${element?.weight} | ${element?.height} "),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
        onTap: () async {
          pokebloc?.pokemonBloc.setPokemon(element);
          _tabController.animateTo(0);
          setState(() {
            selectedIndex = 0;
            pokemon = element?? PokemonB();
          });
        },
      ));
    });

    return l;

  }

  Widget _likeBTN() {
    return Row(
      children: [
        _btnBuscar(),
        IconButton(
          onPressed: () {},
          icon:  Icon(Icons.favorite_border, color: color,),
        ),
      ],
    );
  }

  IconButton _btnBuscar() {
    return IconButton(
        onPressed: () => {
          showSearch(
            context: context, 
            delegate: SearchPokemonDelegate())
        }, 
        icon: Icon(Icons.search, color: color,)
      );
  }

  Widget _info(BuildContext context, PokemonB? pokemon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [        
        Center(
          child: Text(
              desc?? '',
              style: TextStyle(
                color: Colors.grey,
                fontSize: getFontSize(context, 18),
              ),
              textAlign: TextAlign.center,
            ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          width: fullWidth(context),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                pokeAminated(int.parse(pokemon?.id?.replaceAll('#', '')?? '0')),
                height: getDimention(context,75),
                errorBuilder: (context, error, stackTrace) {
                  return  Image.asset( 
                    officialImageURL(int.parse(pokemon?.id?.replaceAll('#', '')?? '0')),
                    width: getFontSize(context, 100),
                    errorBuilder: (context, error, stackTrace) {
                      return  Image.asset( 'assets/images/pokeball.gif');
                    },                    
                  );
                },
                fit: BoxFit.fitHeight,                       
              ),
              const SizedBox(
                width: 100,
              ),
              Image.asset(
                pokeShinyAminated(int.parse(pokemon?.id?.replaceAll('#', '')?? '0')),
                errorBuilder: (context, error, stackTrace) {
                  return  Image.asset( 
                    officialShinyImageURL(int.parse(pokemon?.id?.replaceAll('#', '')?? '0')),
                    width: getFontSize(context, 100),
                    errorBuilder: (context, error, stackTrace) {
                      return  Image.asset( 'assets/images/pokeball.gif');
                    },                    
                  );
                },
                height: getDimention(context,75),
                fit: BoxFit.fitHeight,                       
              ),
            ],
          ),
        ),
        InfoCard(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${pokemon?.weight}',
                    style: TextStyle(
                         fontFamily: 'Circular-bold',fontSize: getFontSize(context, 18)),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  customText('Peso',style: TextStyle(fontSize: getFontSize(context,14)),)
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${pokemon?.height}',
                    style: TextStyle(
                         fontFamily: 'Circular-bold',fontSize: getFontSize(context,18)),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text('Altura',style: TextStyle(fontSize: getFontSize(context,14)),)
                ],
              ),
              
            ],
          ),
        ),
       const SizedBox(height: 40,),
       _debilidades(context, pokemon),
        const SizedBox(height: 40,),
        _cria(context, pokemon),
        const SizedBox(height: 20,),
        _entrenamiento(context, pokemon),
      ],
    );
  }

  Widget _debilidades(BuildContext context, PokemonB? pokemon) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: fullWidth(context) * 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
                'Debilidades',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: getFontSize(context, 20)
                )
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: _tiposDebilidades(pokemon),
            )
        ],
      ),
    );
  }

  _tiposDebilidades(PokemonB? pokemon){

    List<Widget> list = [];

    pokemon?.weaknesses?.forEach((element) {
      list.add(TypeBadge(type: element, onlyImage: true, moderno: true,));
    });

    return list;
  }

  Widget _entrenamiento(BuildContext context, PokemonB? pokemon) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: fullWidth(context) * 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'Entrenamiento',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: getFontSize(context, 20)
              )
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: .1),
            leading: Text(
                'Exp. Base',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: getFontSize(context, 18)
                )
            ),
            title: Text(
                    pokemon?.baseExp?? '',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: getFontSize(context, 18)
                    ),
                  ),
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: .1),
            leading: Text(
                'Habilidades',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: getFontSize(context, 18)
                )
            ),
            title: Text(
                    pokemon?.abilities?[0].toString()?? '',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: getFontSize(context, 18)
                    ),
                  ),
          )
        ],
      ),
    );
  }

  Widget _cria(BuildContext context, PokemonB? pokemon) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: fullWidth(context) * 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(getFontSize(context, 1)),
            child: Text(
                'Crianza',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: getFontSize(context, 20)
                )
              ),
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: .1),
            leading: Text(
                'Genero:',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: getFontSize(context, 18)
                )
            ),
            title: Row(
              children: [
                  Text(
                    '♂️',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: getFontSize(context, 18)
                    ),
                  ),
                  Text(
                    pokemon?.malePercentage?? '',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: getFontSize(context, 18)
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Text(
                    '♀️',
                    style: TextStyle(
                      color: Colors.pink,
                      fontSize: getFontSize(context, 18)
                    ),
                  ),
                  Text(
                    pokemon?.femalePercentage?? '',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: getFontSize(context, 18)
                    ),
                  ),
              ],
            ),
          ),
          ListTile(
            leading: Text(
                'Grupo Huevo:',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: getFontSize(context, 18)
                )
            ),
            title: Row(
              children: [
                  Text(
                    pokemon?.eggGroups?? '',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: getFontSize(context, 18)
                    ),
                  ),
              ],
            ),
          ),
          ListTile(
            leading: Text(
                'Ciclo Huevo:',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: getFontSize(context, 18)
                )
            ),
            title: Row(
              children: [
                  Text(
                    pokemon?.cycles?? '',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: getFontSize(context, 18)
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _invertirOpacity(){

    if(opacity == 0){
      return 1.0;
    }else if(opacity == 1.0){
      return 0.0;
    }else{
      double o = 0;

      o = (opacity - 1).abs();

      if(o < 0){
        o = 0.0;
      }else if(o > 1){
        o = 1.0;
      }

      return o;
    }
  }

  List<Widget> _tipos(List<dynamic>? types, Size size) {

    var list =List<Widget>.empty(growable: true);
    types?.forEach((element) {
      list.add(Padding(
        padding:  EdgeInsets.symmetric(horizontal: fullWidth(context) * 0.01),
        child: TypeBadge(type: element),
      ));
    });

    return list;
  }

  Widget _stats(PokemonB? pokemon){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [ 
        const SizedBox(
          height: 20,
        ),
        _statsList(pokemon),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Text _number(Size size, PokemonB? pokemon) {
    return Text(
          pokemon?.id?? '',
          
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  fontSize: fullHeight(context) * 0.02
                ),
        );
  }

  _statsList(PokemonB? pokemon){

    // var list = pokemon?.stats;
    var widgetsList = List<Widget>.empty(growable: true);

    //HP
    widgetsList.add(Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: getDimention(context, 80),
              child: Text(
                  'HP',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: getFontSize(context, 18),
                    overflow: TextOverflow.ellipsis
                  ),
                ),
            ),
            Center(
              child: Text(
                  '${pokemon?.hp}',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: getFontSize(context,18),
                    overflow: TextOverflow.ellipsis
                  ),
                ),
            ),
            Center(
              heightFactor: 2,
              child: LinearPercentIndicator(
                  width: fullWidth(context) * 0.35,
                  animation: true,
                  lineHeight: getFontSize(context, 15),
                  animationDuration: 2000,
                  percent: ((pokemon?.hp?? 1) / divider).toDouble(),
                  barRadius: const Radius.circular(20),
                  progressColor: typeColor(type: pokemon?.typeofpokemon?[0]),
                  backgroundColor: Colors.grey[300],
                ),
            ),
          ],
        ));
    widgetsList.add(const SizedBox(height: 10,));
    //attack
    widgetsList.add(Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: getDimention(context, 80),
              child: Text(
                  'AT',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: getFontSize(context, 18),
                    overflow: TextOverflow.ellipsis
                  ),
                ),
            ),
            Center(
              child: Text(
                  '${pokemon?.attack}',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: getFontSize(context,18),
                    overflow: TextOverflow.ellipsis
                  ),
                ),
            ),
            Center(
              heightFactor: 2,
              child: LinearPercentIndicator(
                  width: fullWidth(context) * 0.35,
                  animation: true,
                  lineHeight: getFontSize(context, 18),
                  animationDuration: 2000,
                  percent: ((pokemon?.attack?? 1) / divider).toDouble(),
                  barRadius: const Radius.circular(20),
                  progressColor: typeColor(type: pokemon?.typeofpokemon?[0]),
                  backgroundColor: Colors.grey[300],
                ),
            ),
          ],
        ));
    widgetsList.add(const SizedBox(height: 10,));
    //defense
    widgetsList.add(Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: getDimention(context, 80),
              child: Text(
                  'DEF',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: getFontSize(context, 18),
                    overflow: TextOverflow.ellipsis
                  ),
                ),
            ),
            Center(
              child: Text(
                  '${pokemon?.defense}',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: getFontSize(context,18),
                    overflow: TextOverflow.ellipsis
                  ),
                ),
            ),
            Center(
              heightFactor: 2,
              child: LinearPercentIndicator(
                  width: fullWidth(context) * 0.35,
                  animation: true,
                  lineHeight: getFontSize(context, 15),
                  animationDuration: 2000,
                  percent: ((pokemon?.defense?? 1) / divider).toDouble(),
                  barRadius: const Radius.circular(20),
                  progressColor: typeColor(type: pokemon?.typeofpokemon?[0]),
                  backgroundColor: Colors.grey[300],
                ),
            ),
          ],
        ));
    widgetsList.add(const SizedBox(height: 10,));
    //specialAttack
    widgetsList.add(Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: getDimention(context, 80),
              child: Text(
                  'SATA',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: getFontSize(context, 18),
                    overflow: TextOverflow.ellipsis
                  ),
                ),
            ),
            Center(
              child: Text(
                  '${pokemon?.specialAttack}',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: getFontSize(context,18),
                    overflow: TextOverflow.ellipsis
                  ),
                ),
            ),
            Center(
              heightFactor: 2,
              child: LinearPercentIndicator(
                  width: fullWidth(context) * 0.35,
                  animation: true,
                  lineHeight: getFontSize(context, 18),
                  animationDuration: 2000,
                  percent: ((pokemon?.specialAttack?? 1) / divider).toDouble(),
                  barRadius: const Radius.circular(20),
                  progressColor: typeColor(type: pokemon?.typeofpokemon?[0]),
                  backgroundColor: Colors.grey[300],
                ),
            ),
          ],
        ));
    widgetsList.add(const SizedBox(height: 10,));
    //specialdef
    widgetsList.add(Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: getDimention(context, 80),
              child: Text(
                  'SDEF',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: getFontSize(context, 18),
                    overflow: TextOverflow.ellipsis
                  ),
                ),
            ),
            Center(
              child: Text(
                  '${pokemon?.specialDefense}',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: getFontSize(context,18),
                    overflow: TextOverflow.ellipsis
                  ),
                ),
            ),
            Center(
              heightFactor: 2,
              child: LinearPercentIndicator(
                  width: fullWidth(context) * 0.35,
                  animation: true,
                  lineHeight: getFontSize(context, 15),
                  animationDuration: 2000,
                  percent: ((pokemon?.specialDefense?? 1) / divider).toDouble(),
                  barRadius: const Radius.circular(20),
                  progressColor: typeColor(type: pokemon?.typeofpokemon?[0]),
                  backgroundColor: Colors.grey[300],
                ),
            ),
          ],
        ));
    widgetsList.add(const SizedBox(height: 10,));
    //speed
    widgetsList.add(Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: getDimention(context, 80),
              child: Text(
                  'VEL',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: getFontSize(context, 18),
                    overflow: TextOverflow.ellipsis
                  ),
                ),
            ),
            Center(
              child: Text(
                  '${pokemon?.speed}',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: getFontSize(context,18),
                    overflow: TextOverflow.ellipsis
                  ),
                ),
            ),
            Center(
              heightFactor: 2,
              child: LinearPercentIndicator(
                  width: fullWidth(context) * 0.35,
                  animation: true,
                  lineHeight: getFontSize(context, 15),
                  animationDuration: 1000,
                  percent: ((pokemon?.speed?? 1) / divider).toDouble(),
                  barRadius: const Radius.circular(20),
                  progressColor: typeColor(type: pokemon?.typeofpokemon?[0]),
                  backgroundColor: Colors.grey[300],
                ),
            ),
          ],
        ));
    widgetsList.add(const SizedBox(height: 10,));
    // //total
    // widgetsList.add(Row(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         SizedBox(
    //           width: getDimention(context, 80),
    //           child: Text(
    //               'TOT',
    //               style: TextStyle(
    //                 color: Colors.grey[400],
    //                 fontSize: getFontSize(context, 18),
    //                 overflow: TextOverflow.ellipsis
    //               ),
    //             ),
    //         ),
    //         Center(
    //           child: Text(
    //               '${pokemon?.total}',
    //               style: TextStyle(
    //                 color: Colors.grey[800],
    //                 fontSize: getFontSize(context,18),
    //                 overflow: TextOverflow.ellipsis
    //               ),
    //             ),
    //         ),
    //         Center(
    //           heightFactor: 2,
    //           child: LinearPercentIndicator(
    //               width: fullWidth(context) * 0.35,
    //               animation: true,
    //               lineHeight: getFontSize(context, 15),
    //               animationDuration: 2000,
    //               percent: ((pokemon?.total?? 1) / divider).toDouble(),
    //               barRadius: const Radius.circular(20),
    //               progressColor: typeColor(type: pokemon?.typeofpokemon?[0]),
    //               backgroundColor: Colors.grey[300],
    //             ),
    //         ),
    //       ],
    //     ));


    return Column(
      children: widgetsList,
    );
  }
}


class CustomBoxShadow extends BoxShadow {
      @override
        // ignore: overridden_fields
        final BlurStyle blurStyle;
    
      const CustomBoxShadow({
        super.color,
        super.offset,
        super.blurRadius,
        this.blurStyle = BlurStyle.normal,
      });
    
      @override
      Paint toPaint() {
        final Paint result = Paint()
          ..color = color
          ..maskFilter = MaskFilter.blur(blurStyle, blurSigma);
        assert(() {
          if (debugDisableShadows) {
            result.maskFilter = null;
          }
          return true;
        }());
        return result;
      }
    }