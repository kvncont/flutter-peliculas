import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  // const CardSwiper({Key key}) : super(key: key);

  final List<Pelicula> peliculas;

  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      // color: Colors.red,
      padding: EdgeInsets.only(top: 20.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.65,
        itemHeight: _screenSize.height * 0.5,
        itemCount: peliculas.length,
        itemBuilder: (BuildContext context, int index){

          peliculas[index].uniqueId = '${peliculas[index].id}-tarjeta';

          return Hero(
            tag: peliculas[index].uniqueId,
            child: ClipRRect(
              borderRadius:  BorderRadius.circular(20.0),
              child: GestureDetector(
                child: FadeInImage(
                  image: NetworkImage(peliculas[index].getPosterIMG()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                ),
                onTap: () => Navigator.pushNamed(context, 'detalle', arguments: peliculas[index]),
              )
            ),
          );
        },
      ),
    );
  }
}
