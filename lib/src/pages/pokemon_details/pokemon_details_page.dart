

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ladex/src/models/pokemon_b.dart';
import 'package:ladex/src/widgets/pokemon/type_badge_widget.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../blocs/bloc_provider.dart';
import '../../utils/general.dart';
import '../../utils/pokemon_types_util.dart';
import '../../widgets/animated_ball.dart';

class PokemonDetailPage extends StatefulWidget  {
  const PokemonDetailPage({Key? key}) : super(key: key);
  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> with TickerProviderStateMixin {
  
  int selectedIndex = 0;
  String? desc = '';
  
  double opacity = 0;
  double divider = 100;
  BlocProvider? pokebloc;
  PokemonB pokemon = PokemonB();
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
    vsync: this, duration: const Duration(milliseconds: 6000));
    _controller.repeat();
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
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


  @override
  Widget build(BuildContext context) {

    if(pokemon.name == null){
      pokemon = ModalRoute.of(context)?.settings.arguments as PokemonB;
    }
    
    final size = tamano(context);
    pokebloc = BlocProvider.of(context);

    pokebloc?.pokemonBloc.evoluciones(pokemon.evolutions);
    
    setState(() {
      setDivider(pokemon.total?? 600);
    });
    
    desc =  pokemon.xdescription??  "${pokemon.ydescription}";

    return Scaffold(
      appBar: opacity > 0.9? AppBar(
        backgroundColor: typeColor(type: pokemon.typeofpokemon?[0]),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        actions: [
          _likeBTN()
        ],
        title: Text(
                  pokemon.name?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: getFontSize(context, 20)
                  ),
                ),
      ) : null ,
      backgroundColor: typeColor(type: pokemon.typeofpokemon?[0]),
      body: _details(context, pokemon, size),
      // body: StreamBuilder(
      //       stream: pokebloc?.pokemonBloc.pokemon, 
      //       builder:(BuildContext context, AsyncSnapshot<PokemonB?> snapshot){
        
      //         if(snapshot.hasData){
      //           return _details(context, snapshot.data, size);
      //         }else{
      //           return Center(
      //             child: Container(
      //               margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
      //               child: const CircularProgressIndicator()
      //             ),
      //           );
      //         }
      //       }
      //   )      
    );
  }

  Stack _details(BuildContext context, PokemonB? pokemon, Size size) {
    return Stack(
      children: [
        Positioned(
          bottom: fullHeight(context) * 0.58,
          right: 50,
          left: 50,
          child: Align(
            heightFactor: getDimention(context,0.75),
            widthFactor: .7,
            child: AnimatedBall(opacity: opacity, imageHeight: getDimention(context,250), controller: _controller,),
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
            color: Colors.white24,
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
                            icon: const Icon(Icons.arrow_back, color: Colors.white,),
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
                                  color: Colors.white,
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
            height: fullHeight(context) * 0.60,
            width: fullWidth(context),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20) ),
              color: Colors.white,
            ),            
          ),
        ),
        Positioned(
              bottom: fullHeight(context) * 0.58,
              right: 50,
              left: 50,
              child: Hero(
                tag: pokemon?.name?? '',
                child: Align(
                  heightFactor: getDimention(context,0.75),
                  widthFactor: .7,
                  child: Opacity(
                    opacity: _invertirOpacity(),
                    child: CachedNetworkImage(
                      alignment: Alignment.topRight,
                      imageUrl: officialImageURL(int.parse(pokemon?.id?.replaceAll('#', '')?? '0')),
                      height: getDimention(context,200),
                      fit: BoxFit.fitHeight,                        
                    ),
                  ),
                ),
              ),
        ),
        SlidingUpPanel(
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
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          panel: Container(
            width: fullWidth(context),
            margin: EdgeInsets.symmetric(horizontal: fullWidth(context) > 1199? getDimention(context, 300) : fullWidth(context) > 500? getDimention(context, 80) : getDimention(context, 15)),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)),
            ),
            child: DefaultTabController(
              length: 3,
              child: Padding(
                padding: EdgeInsets.only(top: fullHeight(context) * 0.04),
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: TabBar(
                    indicatorColor: typeColor(type: pokemon?.typeofpokemon?[0]),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black54,
                    indicatorPadding: EdgeInsets.symmetric(horizontal: getDimention(context, 10)),
                    dividerColor: Colors.transparent,
                    tabs:  [
                      Tab( child: Text('General',style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w900,fontSize: getFontSize(context, 13)),),),
                      Tab(child: Text('Estadisticas',style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w900,fontSize: getFontSize(context, 13)),),),
                      Tab(child: Text('Evoluciones',style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w900,fontSize: getFontSize(context, 13)),),)
                    ],
                  ),
                  body: TabBarView(
                    children: [
                      DraggableScrollableSheet(
                        initialChildSize: 0.95,
                        builder: (context, scrollController){
                          return SingleChildScrollView(
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
        leading: CachedNetworkImage(imageUrl: pokeAminated(int.parse(element?.id?.replaceAll('#', '')?? '0')), width: getDimention(context, 100)),
        subtitle: Text("${element?.weight} | ${element?.height} "),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
        onTap: () async {
           //  PokeAPI.getObject<Species>(int.parse(pokemon?.id?.replaceAll('#', '')?? '0')).then((value) => pokemon?.ydescription =value?.flavorTextEntry?.replaceAll(RegExp(r'\n'), ' ')?? '');
            pokebloc?.pokemonBloc.setPokemon(element);

            // // navigate to pokemon details page
            // Navigator.pushNamed(context, 'pk_details', arguments: element);

            setState(() {
              pokemon = element?? PokemonB();
            });
        },
      ));
    });

    return l;

  }

  IconButton _likeBTN() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.favorite_border, color: Colors.white,),
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
              CachedNetworkImage(
                alignment: Alignment.topRight,
                imageUrl: pokeAminated(int.parse(pokemon?.id?.replaceAll('#', '')?? '0')),
                height: getDimention(context,75),
                fit: BoxFit.fitHeight,                       
              ),
              const SizedBox(
                width: 100,
              ),
              CachedNetworkImage(
                alignment: Alignment.topRight,
                imageUrl: pokeShinyAminated(int.parse(pokemon?.id?.replaceAll('#', '')?? '0')),
                height: getDimention(context,75),
                fit: BoxFit.fitHeight,                       
              ),
            ],
          ),
        ),
        Container(
            height: getFontSize(context, 100),
            margin: EdgeInsets.symmetric(horizontal: getFontSize(context, 30), vertical: getFontSize(context, 10)),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    blurRadius: 20,
                    color: Colors.grey.withOpacity(.2),
                    offset: const Offset(0, 5),
                  )
                ]),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: getFontSize(context, 18)),
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
                          color: Colors.black87, fontFamily: 'Circular-bold',fontSize: getFontSize(context, 18)),
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
                          color: Colors.black87, fontFamily: 'Circular-bold',fontSize: getFontSize(context,18)),
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
       _debilidades(context, pokemon),
        const SizedBox(height: 40,),
        _cria(context, pokemon),
        const SizedBox(height: 20,),
        _entrenamiento(context, pokemon),
      ],
    );
  }

  Widget _debilidades(BuildContext context, PokemonB? pokemon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
              'Debilidades',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black87,
                fontSize: getFontSize(context, 20)
              )
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: _tiposDebilidades(pokemon),
          )
      ],
    );
  }

  _tiposDebilidades(PokemonB? pokemon){

    List<Widget> list = [];

    pokemon?.weaknesses?.forEach((element) {
      list.add(TypeBadge(type: element, onlyImage: true, moderno: true,));
    });

    return list;
  }

  Column _entrenamiento(BuildContext context, PokemonB? pokemon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            'Entrenamiento',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black87,
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
    );
  }

  Widget _cria(BuildContext context, PokemonB? pokemon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(getFontSize(context, 1)),
          child: Text(
              'Crianza',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black87,
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
                  color: Colors.white,
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
                  animationDuration: 2000,
                  percent: ((pokemon?.speed?? 1) / divider).toDouble(),
                  barRadius: const Radius.circular(20),
                  progressColor: typeColor(type: pokemon?.typeofpokemon?[0]),
                  backgroundColor: Colors.grey[300],
                ),
            ),
          ],
        ));
    widgetsList.add(const SizedBox(height: 10,));
    //total
    widgetsList.add(Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: getDimention(context, 80),
              child: Text(
                  'TOT',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: getFontSize(context, 18),
                    overflow: TextOverflow.ellipsis
                  ),
                ),
            ),
            Center(
              child: Text(
                  '${pokemon?.total}',
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
                  percent: ((pokemon?.total?? 1) / divider).toDouble(),
                  barRadius: const Radius.circular(20),
                  progressColor: typeColor(type: pokemon?.typeofpokemon?[0]),
                  backgroundColor: Colors.grey[300],
                ),
            ),
          ],
        ));


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
        Color color = const Color(0xFF000000),
        Offset offset = Offset.zero,
        double blurRadius = 0.0,
        this.blurStyle = BlurStyle.normal,
      }) : super(color: color, offset: offset, blurRadius: blurRadius);
    
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