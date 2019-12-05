import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperCard extends StatelessWidget {
  final List items;
  final SwiperLayout tipo;
  const SwiperCard({Key key, @required this.items, @required this.tipo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Swiper(
        itemBuilder: (BuildContext context,int index){
          return  FadeInImage(
            placeholder: AssetImage('assets/cargando.gif'),
            image: NetworkImage(items[index]),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          );
        },
        itemCount: items.length,
        itemWidth: 300.0,
        layout: tipo,
        scale: 0.9,
        viewportFraction: 0.8,
        autoplay: true,
        autoplayDelay: 3000,
      );
  }
}