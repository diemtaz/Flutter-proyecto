import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_places/Widgets/MenuLateral.dart';
/*import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPlace extends StatefulWidget {
  LocationPlace({Key key}) : super(key: key);
  final Set<Marker> _markers = Set();
  static double lat = 40.7128;
  static double long = -74.0060;

  initState() {
    _markers.add(
      Marker(
        markerId: MarkerId('newyork'),
        position: LatLng(lat, long),
      ),
    );
  }

  @override
  _LocationPlaceState createState() => _LocationPlaceState();
}

class _LocationPlaceState extends State<LocationPlace> {
  final Set<Marker> _markers = Set();

  CameraPosition _initialPosition = CameraPosition(
    target: LatLng(LocationPlace.lat, LocationPlace.long),
    zoom: 13,
  );

  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trip Places"),
      ),
      endDrawer: MenuLateral(),
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
       
      ),
    );
  }
}
*/