
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_places/src/models/place_model.dart';
import 'package:flutter_places/src/models/placecomments_model.dart';

class PlaceRepository {
  final placesCollection = Firestore.instance.collection('places');

  Future<void> add(Places places) {
    return placesCollection.add(places.toJson());
  }

  Stream<List<Places>> all() {
    return placesCollection
        .snapshots()
        .map(
      (snapshot) {
        return snapshot.documents
            .map(
              (doc) => Places.fromSnapshot(doc),
            )
            .toList();
      },
    );
  }

    Future<void> addComments(PlacesComments placesComments, String idPlace) {
    return placesCollection
        .document(idPlace)
        .collection('comments')
        .add(placesComments.toJson());
  }

  Stream<List<PlacesComments>> comments(String idPlace) {
    return placesCollection
        .document(idPlace)
        .collection('comments')
        .snapshots()
        .map(
      (snapshot) {
        return snapshot.documents
            .map(
              (doc) => PlacesComments.fromSnapshot(doc),
            )
            .toList();
      },
    );
  }

}