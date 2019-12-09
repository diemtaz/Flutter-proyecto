import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_places/Widgets/MenuLateral.dart';
import 'package:flutter_places/Widgets/page_view_widget.dart';
import 'package:flutter_places/src/models/place_model.dart';
import 'package:flutter_places/src/repository/place_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  PlaceRepository _placeRepository = new PlaceRepository();
  FirebaseUser mCurrentUser;
FirebaseAuth _auth;
   


@override
void initState() { 
  super.initState();
  _auth = FirebaseAuth.instance;
 
}


  
  String path = "assets/images/";


  @override
  Widget build(BuildContext context) {
final String user = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Trip Places"),
      ),
      endDrawer: MenuLateral(),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: _listPlaces(user),
            ),
          )
        ],
      ),
    );
  }



  Widget _listPlaces(String userId) {
    return StreamBuilder(
      stream: _placeRepository.favorites(userId), 
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
