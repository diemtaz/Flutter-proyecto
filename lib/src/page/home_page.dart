import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_places/Widgets/MenuLateral.dart';
import 'package:flutter_places/Widgets/SwiperCard.dart';
import 'package:flutter_places/Widgets/page_view_widget.dart';
import 'package:flutter_places/src/models/place_model.dart';
import 'package:flutter_places/src/repository/place_repository.dart';
import 'package:flutter_places/src/repository/user_repository.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PlaceRepository _placeRepository = new PlaceRepository();
  UserRepository _userRepository = new UserRepository();
  
  Size _scrSize;
  String path = "assets/images/";
  

  @override
  Widget build(BuildContext context) {
    _scrSize = MediaQuery.of(context).size;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Trip Places"),
      ),
      endDrawer: MenuLateral(),
      body: Column(
        children: <Widget>[
          _backgroundimage(),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: _listPlaces(),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(color: Colors.black, blurRadius: 10.0, offset: Offset(0, 7))
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[Icon(Icons.home), Text('Inicio')],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[Icon(Icons.explore), Text('Localización')],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[Icon(Icons.settings), Text('Opciones')],
            )
          ],
        ),
      ),
    );
  }

  Widget _backgroundimage() {
    /*return Image.asset('assets/images/back_top.jpg',
        fit: BoxFit.cover,
        width: double.infinity,
        height: _scrSize.height * 0.25);*/

    return StreamBuilder(
      stream: _placeRepository.images(),
      builder: (BuildContext context, AsyncSnapshot<List<Places>> snapshot) {
        List<dynamic> imagen;
        if (!snapshot.hasData) return CircularProgressIndicator();

        List<Places> data = snapshot.data;
        imagen = data.map((f) {
          return f.imagenes[0];
        }).toList();

        //SwiperLayout.STACK
        return Container(
          height: _scrSize.height * 0.25,
          child: SwiperCard(
            items: imagen,
            tipo: SwiperLayout.DEFAULT,
          ),
        );
      },
    );
  }

  Widget _listPlaces() {
    return StreamBuilder(
      stream: _placeRepository.all(),
      builder: (BuildContext context, AsyncSnapshot<List<Places>> snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        List<Places> data = snapshot.data;
        return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  Container(
                    child: ListTile(
                      onTap: () => Navigator.pushNamed(context, "detail",
                          arguments: data[index]),
                      title: Text(data[index].name),
                      subtitle:
                          Text("${data[index].city} - ${data[index].country}"),
                      trailing: Icon(Icons.more_vert),
                    ),
                  ),
                  Container(
                    height: 200,
                    child: PageViewWidget(items: data[index].imagenes),
                  ),
                  
                ],
              );
            });
      },
    );
  }

  
}
