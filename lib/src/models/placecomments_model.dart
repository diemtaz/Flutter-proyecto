import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'placecomments_model.g.dart';

@JsonSerializable()
class PlacesComments {
  final String id;
  final String comment;
  final String autor;
 

  PlacesComments({
    this.id,
    this.comment,
    this.autor
  });

factory PlacesComments.fromJson(Map<String, dynamic> json) =>
      _$PlacesCommentsFromJson(json);

  Map<String, dynamic> toJson() => _$PlacesCommentsToJson(this);


static PlacesComments fromSnapshot(DocumentSnapshot snap) {
    return PlacesComments(
      id: snap.documentID,
      comment: snap.data['comment'],
      autor: snap.data['autor'],

    );
  }

}