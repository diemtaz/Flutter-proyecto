import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperCard extends StatelessWidget {
  final List items;
  const SwiperCard({Key key, @required this.items}) : super(key: key);

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
        layout: SwiperLayout.STACK,
        autoplay: true,
        autoplayDelay: 3000,
      );
  }
}