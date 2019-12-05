import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_places/src/models/place_model.dart';
import 'package:latlong/latlong.dart';




class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
MapController map = new MapController();
String tipoMapa ='streets';

  @override
  Widget build(BuildContext context) {

    final Places place = ModalRoute.of(context).settings.arguments; 

    return Scaffold(
      appBar: AppBar(
        title: Text("Trip Places"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: (){
              map.move(place.getLatLng(),15);
            },
          )
        ],
      ),
      body: _crearFlutterMap(place),
      floatingActionButton: _crearButton(context),
    );
  }

  Widget _crearButton(BuildContext context){
    return FloatingActionButton(
        child: Icon(Icons.repeat),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: (){
            if (tipoMapa == 'streets'){
               tipoMapa ='dark';
            }else if (tipoMapa =='dark'){
              tipoMapa ='light';
            }else if (tipoMapa =='light'){
              tipoMapa ='outdoors';
            }else if (tipoMapa =='outdoors'){
              tipoMapa ='satellite';
            } else{
              tipoMapa = 'streets';
            }
             setState(() {
               
             });
        },
    );
  }

  Widget _crearFlutterMap( Places place ) {

    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center: place.getLatLng(),
        zoom: 15
      ),
      layers: [
        _crearMapa(),
        _markers(place),
      ],
    );
  }

  _crearMapa() {

    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken': 'pk.eyJ1IjoiZGllbXRheiIsImEiOiJjazNraWg1anMwdWF1M2ptdnh2dTFrZTlhIn0._po2QEcUKE67SNZysJIuzQ',
        'id': 'mapbox.$tipoMapa'
      }
    );
  }

  _markers(Places place){
      return MarkerLayerOptions(
        markers: <Marker>[
          Marker(
            width: 100.0,
            height: 100.0,
            point: place.getLatLng(),
            builder: (context) => Container(
              child: Icon(
                Icons.location_on,
                color: Theme.of(context).primaryColor,
                size: 45.0
              ),
            )
          )
        ]
      );
  }
}
