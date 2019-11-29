import 'package:flutter/material.dart';

class PageViewWidget extends StatelessWidget {
  final List items;

  final _pageController =
      PageController(initialPage: 1, viewportFraction: 0.30);

  PageViewWidget({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      pageSnapping: false,
      controller: _pageController,
      itemCount: items.length,
      itemBuilder: (context, idx) => GestureDetector(
        child: Container(
            child: Card(
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: FadeInImage(
            placeholder: AssetImage('assets/cargando.gif'),
            image: NetworkImage(items[idx]),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        )),
        onTap: () {},
      ),
    );
  }
}
