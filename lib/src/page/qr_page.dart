import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_places/Widgets/MenuLateral.dart';
import 'package:flutter_places/src/models/place_model.dart';
import 'package:flutter_places/src/repository/place_repository.dart';
import 'package:qrcode_reader/qrcode_reader.dart';

class QrPage extends StatelessWidget {
  PlaceRepository _placeRepository = new PlaceRepository();

  StreamController<String> _codeScan = StreamController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trip Places"),
      ),
      endDrawer: MenuLateral(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Escanea código QR'),
            RaisedButton(
              onPressed: () => _scan(context),
              child: Text('Escanear!'),
            ),
            StreamBuilder<String>(
              stream: _codeScan.stream,
              builder: (context, snapshot) {
                return Text('');
              }
            ),
            
          ],
        ),
      ),
      
    );
  }
   _scan(context) async{
    String code;
    Places place;
    try {
print('ingreso aqui444');
      code = await QRCodeReader().scan();

      if(code != null){
        print(code);
      place = await _placeRepository.qrplace(code);
      print(place);
      Navigator.pushNamed(context, "detail",
                          arguments: place);
      }


    } catch (e) {
      _codeScan.add('Ha ocurrido un error al escanear..');
    }
  }
}