import 'package:flutter/material.dart';

import '../models/pelicula_model.dart';
import '../providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {

  String seleccion = '';
  final peliculasProvider = new PeliculasProvider();

  // final peliculas = [
  //   'Spiderman',
  //   'Superman',
  //   'Aquaman',
  //   'Batman',
  //   'Shazam',
  //   'Ironman',
  //   'Ironman 2',
  //   'Ironman 3',
  //   'Ironman 4',
  //   'Capitan America',
  // ];

  // final peliculasRecientes = [
  //   'Spiderman',
  //   'Capitan America',
  // ];


  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro AppBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          // print('Ations icon clear');
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono o cualquier cosa a la izquierda del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow, 
        progress: transitionAnimation,
      ),
      onPressed: (){
        // print('Leading icon press');
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que se mostraran
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias cuando la persona escribe
    if(query.isEmpty){
      return Container();
    } 
    
    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot){
        if (snapshot.hasData) {
          final peliculas = snapshot.data;
          return ListView(
            children: peliculas.map((pelicula) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(pelicula.getPosterIMG()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  width: 50.0,
                  fit: BoxFit.cover,                    
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: (){
                  close(context, null);
                  pelicula.uniqueId = '';
                  Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                },
              );
            }).toList()
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   // Son las sugerencias cuando la persona escribe

  //   final listaSugerida = (query.isEmpty) ? peliculasRecientes : peliculas.where((p) => p.toLowerCase().startsWith(query.toLowerCase())).toList();

  //   return ListView.builder(
  //     itemCount: listaSugerida.length,
  //     itemBuilder: (context, index) {
  //       return ListTile(
  //         leading: Icon(Icons.movie),
  //         title: Text(listaSugerida[index]),
  //         onTap: () {
  //           // print('Mostrando detalles...');
  //           seleccion = listaSugerida[index];
  //           showResults(context);
  //         },
  //       );
  //     },
  //   );
  // }
  
}