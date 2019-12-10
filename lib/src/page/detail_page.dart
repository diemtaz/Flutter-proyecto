import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_places/Widgets/MenuLateral.dart';
import 'package:flutter_places/Widgets/SwiperCard.dart';
import 'package:flutter_places/src/models/place_model.dart';
import 'package:flutter_places/src/models/placecomments_model.dart';
import 'package:flutter_places/src/page/styles/text_style.dart';
import 'package:flutter_places/src/repository/place_repository.dart';
import 'package:flutter_places/src/repository/user_repository.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Detailpage extends StatefulWidget {
  Detailpage({Key key}) : super(key: key);
  static final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  _DetailpageState createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  bool liked = false;
  bool user_id = false;

  Size _scrSize;

  _pressed() async {
    setState(() {
      liked = !liked;
    });
  }

  FirebaseUser user;

  PlaceRepository _placeRepository = new PlaceRepository();

  UserRepository _userRepository = new UserRepository();

  TextEditingController _comment = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _scrSize = MediaQuery.of(context).size;

    final Places places = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Trip Places"),
      ),
      endDrawer: MenuLateral(),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
            top: 300.0,
            child: Opacity(
              child: Image.asset(
                "assets/image_01.png",
                fit: BoxFit.fill,
              ),
              opacity: 0.3,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  height: _scrSize.height * 0.40,
                  width: double.infinity,
                  child: SwiperCard(
                    items: places.imagenes,
                    tipo: SwiperLayout.STACK,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () => Navigator.pushNamed(context, "location",
                          arguments: places),
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFF0D47A1),
                              Color(0xFF1976D2),
                              Color(0xFF42A5F5),
                            ],
                          ),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: const Text('Ubicacion',
                            style: TextStyle(fontSize: 20)),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () => Navigator.pushNamed(context, "location",
                          arguments: places),
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        height: 45,
                        width: 105,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFF0D47A1),
                              Color(0xFF1976D2),
                              Color(0xFF42A5F5),
                            ],
                          ),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            _like(places),
                            Text(
                              '${places.like.length}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                horizontalLine(),
                Column(
                  children: <Widget>[
                    _titulos('${places.name} - ${places.city}'),
                    Container(
                      padding:
                          EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                      child: _detalle('${places.description}',
                          estilo: textStyleOrigen),
                    ),
                    _titulos('Comentarios'),
                    _listComments(places.id),
                    _newComment(places.id),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _detalle(String text, {String autor = "", TextStyle estilo}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 15.0),
              blurRadius: 15.0),
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, -10.0),
            blurRadius: 15.0,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Text(text, style: estilo),
          if (autor != "")
            Text(
              'Escrito por: ' + autor,
              style: textStyleSubtitle,
            ),
        ],
      ),
    );
  }

  Widget _newComment(String idx) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 15.0),
              blurRadius: 15.0),
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, -10.0),
            blurRadius: 15.0,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          if (_userRepository.status == Status.Authenticated)
            Form(
              key: Detailpage._formkey,
              child: TextFormField(
                controller: _comment,
                autofocus: false,
                textCapitalization: TextCapitalization.sentences,
                inputFormatters: [new LengthLimitingTextInputFormatter(200)],
                maxLines: 6,
                validator: (val) {
                  return val.trim().isEmpty
                      ? 'Escriba un comentario por favor'
                      : null;
                },
                onSaved: (value) async {
                  final FirebaseUser autor =
                      await _userRepository.getCurrentUser();
                  PlacesComments placesComments =
                      new PlacesComments(comment: value, autor: autor.email);
                  await _placeRepository.addComments(placesComments, idx);
                  _comment.clear();
                },
              ),
            ),
          if (_userRepository.status == Status.Authenticated)
            RaisedButton(
              onPressed: () {
                if (Detailpage._formkey.currentState.validate())
                  Detailpage._formkey.currentState.save();
              },
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.0),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF0D47A1),
                      Color(0xFF1976D2),
                      Color(0xFF42A5F5),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child: const Text('Agregar comentario',
                    style: TextStyle(fontSize: 20)),
              ),
            ),
        ],
      ),
    );
  }

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Container(
          height: 2.0,
          color: Colors.blue.withOpacity(.9),
        ),
      );

  Widget _listComments(String idx) {
    return StreamBuilder(
      stream: _placeRepository.comments(idx),
      builder:
          (BuildContext context, AsyncSnapshot<List<PlacesComments>> snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();

        List<PlacesComments> data = snapshot.data;

        return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  padding: EdgeInsets.all(5),
                  child: _detalle(data[index].comment,
                      autor: data[index].autor, estilo: textStyleDescProfile));
            });
      },
    );
  }

  Widget _titulos(String titulo) {
    return Container(
      alignment: Alignment(0, 0),
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF6078ea).withOpacity(.5),
            offset: Offset(0.0, 3.0),
            blurRadius: 8.0,
          ),
        ],
      ),
      child: Text(
        titulo,
        style: TextStyle(
          color: Colors.white,
          fontFamily: "Poppins-Bold",
          fontSize: 18,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _like(Places places) {
    liked = true;
    setState(() {
      liked = !liked;
      
    });

    return (_userRepository.status == Status.Authenticated)
        ? IconButton(
            icon: Icon(
              liked ? Icons.favorite : Icons.favorite_border,
              color: liked ? Colors.red : Colors.white,
            ),
            onPressed: (liked)
                ? () => null
                : () async {
                  
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                String user = prefs.getString('userId');
                    List<dynamic> mg = new List();
                    mg.addAll(places.like);
                    mg.add(user);

                    await _placeRepository.update(places.copyWith(like: mg));
                    liked=false;
                    _pressed();
                  },
          )
        : Container();
  }
}
