// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'placecomments_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlacesComments _$PlacesCommentsFromJson(Map<String, dynamic> json) {
  return PlacesComments(
    id: json['id'] as String,
    comment: json['comment'] as String,
    autor: json['autor'] as String,
  );
}

Map<String, dynamic> _$PlacesCommentsToJson(PlacesComments instance) =>
    <String, dynamic>{
      'id': instance.id,
      'comment': instance.comment,
      'autor': instance.autor,
    };
