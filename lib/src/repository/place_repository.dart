
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_places/src/models/place_model.dart';
import 'package:flutter_places/src/models/placecomments_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PlaceRepository {
  FirebaseUser mCurrentUser;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  PlaceRepository(){

_getCurrentUser ();
  }
  _getCurrentUser () async {
  mCurrentUser = await _firebaseAuth.currentUser();
  SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('userId', mCurrentUser.uid);
          await prefs.setString('email', mCurrentUser.email);

}
  final placesCollection = Firestore.instance.collection('places');

  Future<void> add(Places places) {
    return placesCollection.add(places.toJson());
  }

  Future<void> update(Places data) async {
    return await placesCollection.document(data.id).updateData(data.toJson());
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

  Stream<List<Places>> favorites(String user) {
    return placesCollection
        .where('like',arrayContains: user)
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

 

  Future<Places> qrplace(String id) async {
    final doc = await placesCollection.document(id).get();
    return (doc.exists) ? Places.fromSnapshot(doc) : null;
  }

  Stream<List<Places>> images() {
    return placesCollection.limit(5)
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

    Future<void> addComments(PlacesComments placesComments, String idPlace) async{
    return await placesCollection
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