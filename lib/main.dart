import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ladex/src/blocs/pokemon_bloc.dart';
import 'package:pokeapi/model/item/item.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Demo Pokedex'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var poke_bloc = PokemonBloc();

  int _offset = 1;
  int _counter = 1;
  final int _limit = 20;
  final scrollController = ScrollController();

  @override
  void initState(){
    super.initState();

    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent == scrollController.offset){
        _offset = _limit * _counter + 1;
        _counter++;

        poke_bloc.getPagesPokemones(offset: _offset, limit: _limit);
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    
    poke_bloc.getPokemones(offset: _offset, limit: _limit);
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: StreamBuilder(
              stream: poke_bloc.pokemones, 
              builder:(BuildContext context, AsyncSnapshot<List<Pokemon?>> snapshot){

                if(snapshot.hasData){
                  return _buildList(snapshot.data);
                }else{
                  return Container(
                    child: CircularProgressIndicator(),
                  );
                }
              }
      ), // This trailing comma makes auto-formatting nicer for build methods.
    )
    );
  }

    Future<void> _refresh() {
    return poke_bloc.getPokemones(offset: _offset, limit: _limit);
  }
  
  Widget _buildList(List<Pokemon?>? list) {
    return RefreshIndicator(
      onRefresh: () => _refresh(),
      displacement: 50,
      child: GridView.builder(
        controller: scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio:  1.4
        ), 
        itemBuilder: (context, index){
                    if(index < (list?.length?? 0)){
            var item = list?[index];
            return Container(child: _buildListTitle(item));
          }
        }
      ),
    );
  }
  
  _buildListTitle(Pokemon? item) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.green[300],
      ),
      child: Container(
        height: 150,
        child: Stack(
          children: [
            Positioned(
              bottom: -20,
              right: -10,
              child: Image.asset('../assets/images/pokeball.png', height: 150, fit: BoxFit.fill)
            ),
            Positioned(
              top: 20,
              left: 10,
              child: Text(
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18
                ),
                item?.name?? '')),
            Positioned(
              top: 50,
              left: 10,
              child: Container(
                decoration: BoxDecoration(                
                  color: Colors.black26,
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                  child: Text(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    item?.types?[0].type?.name?? ''),
                ),
              )
            ),
            Positioned(
              bottom: 5,
              right: 5,
              child: CachedNetworkImage(
                imageUrl: item?.sprites?.frontDefault?? '',
                height: 150,
                fit: BoxFit.fitHeight,

              ),
            ),
          ],
        ),
      ),
    );
    // return ListTile(
    //   title: Text(item?.name?? ''),
    //   leading: Image.network(
    //     item?.sprites?.frontDefault?? '',
    //     fit: BoxFit.fill,
    //   ),
    // );
  }
}
