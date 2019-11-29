// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Places _$PlacesFromJson(Map<String, dynamic> json) {
  return Places(
    id: json['id'] as String,
    name: json['name'] as String,
    city: json['city'] as String,
    country: json['country'] as String,
    description: json['description'] as String,
    geo: json['geo'] as String,
    imagenes: json['imagenes'] as List,
    like: json['like'] as List,
  );
}

Map<String, dynamic> _$PlacesToJson(Places instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'city': instance.city,
      'country': instance.country,
      'description': instance.description,
      'geo': instance.geo,
      'imagenes': instance.imagenes,
       'like': instance.like,
    };
