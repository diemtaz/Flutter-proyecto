import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

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

factory Places.fromJson(Map<String, dynamic> json) =>
      _$PlacesFromJson(json);

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

}