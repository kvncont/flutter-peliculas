import 'package:flutter/material.dart';

import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  // const MovieHorizontal({Key key}) : super(key: key);

  final List<Pelicula> peliculas;
  final Function siguientePagina;
  
  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3
  );

  @override
  Widget build(BuildContext context) {
    
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener((){
      if (_pageController.position.pixels >= _pageController.position.maxScrollExtent -200) {
        siguientePagina();
      }
    });
    
    return Container(
      // color: Colors.blue,
      height: _screenSize.height * 0.225,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        // children: _tarjetas(context),
        itemCount: peliculas.length,
        itemBuilder: (context, index) => _tarjeta(context, peliculas[index]),
      ),
    );
  }

  // Widget que se usaban para el PageView 
  // List<Widget> _tarjetas(BuildContext context) {

  //   return peliculas.map((pelicula){
  //     return Container(
  //       margin: EdgeInsets.only(right: 15.0),
  //       child: Column(
  //         children: <Widget>[
  //           ClipRRect(
  //             borderRadius: BorderRadius.circular(20.0),
  //             child: FadeInImage(
  //               image: NetworkImage(pelicula.getPosterIMG()),
  //               placeholder: AssetImage('assets/img/no-image.jpg'),
  //               fit: BoxFit.cover,
  //               height: 160.0,
  //             ),
  //           ),
  //           Text(
  //             pelicula.title,
  //             overflow: TextOverflow.ellipsis,
  //             style: Theme.of(context).textTheme.caption,
  //           )
  //         ],
  //       ),
  //     );
  //   }).toList();
  // }

  // Widget usado para el pageView.builder
  Widget _tarjeta(BuildContext context, Pelicula pelicula){

    final _screenSize = MediaQuery.of(context).size;
    pelicula.uniqueId = '${pelicula.id}-poster';

    final tarjerta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[          
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPosterIMG()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: _screenSize.height * 0.2,
                width: 100.0,
              ),
            ),
          ),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );

    return GestureDetector(
      child: tarjerta,
      onTap: (){
        print('Titulo de la pelicula: ${pelicula.title}');
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
    );
  }
}
