import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:latlong/latlong.dart';

part 'place_model.g.dart';

@JsonSerializable()
class Places {
  final String id;
  final String name;
  final String city;
  final String country;
  final String description;
  final String geo;
  final List<dynamic> imagenes;
  final List<dynamic> like;

  Places({
    this.id,
    this.name,
    this.city,
    this.country,
    this.description,
    this.geo,
    this.imagenes,
    this.like,
  });

  factory Places.fromJson(Map<String, dynamic> json) => _$PlacesFromJson(json);

  Map<String, dynamic> toJson() => _$PlacesToJson(this);

  static Places fromSnapshot(DocumentSnapshot snap) {
    return Places(
      id: snap.documentID,
      name: snap.data['name'],
      city: snap.data['city'],
      country: snap.data['country'],
      description: snap.data['description'],
      geo: snap.data['geo'],
      imagenes: snap.data['imagenes'],
      like: snap.data['like'],
    );
  }

  LatLng getLatLng() {
    final lalo = geo.split(',');
    return LatLng(double.parse(lalo[0]), double.parse(lalo[1]));
  }

  Places copyWith({
    String id,
    String name,
    String city,
    String country,
    String description,
    String geo,
    List<dynamic> imagenes,
    List<dynamic> like,
  }) {
    return Places(
      id: id ?? this.id,
      name: name ?? this.name,
      city: city ?? this.city,
      country: country ?? this.country,
      description: description ?? this.description,
      geo: geo ?? this.geo,
      imagenes: imagenes ?? this.imagenes,
      like: like ?? this.like,
    );
  }
}
