import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_places/src/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserRepository with ChangeNotifier {
  final userCollection = Firestore.instance.collection('user');
  FirebaseAuth _firebaseAuth;
  GoogleSignIn _googleSignIn;
  Status _status;
  FirebaseUser _user ;
  FirebaseUser mCurrentUser;

  UserRepository._internal() {
    if (_firebaseAuth == null || _googleSignIn == null) {
      _firebaseAuth = FirebaseAuth.instance;
      _googleSignIn = GoogleSignIn();
      _status = Status.Uninitialized;
      _firebaseAuth.onAuthStateChanged.listen(_onAuthStateChanged);
      
    _getCurrentUser();
    }
    else
    _getCurrentUser();
  }

  static final _instance = UserRepository._internal();
   
  factory UserRepository(){
    return _instance;
  }
_getCurrentUser () async {
  mCurrentUser = await _firebaseAuth.currentUser();
}


  Status get status => _status;
  FirebaseUser get user => _user;

  Future<FirebaseUser> signInWithGoogle() async {
    try {
      _status = Status.Authenticating;
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
      _user = await _firebaseAuth.currentUser();

      return _user;
    } catch (e) {
      print(e);
      _status = Status.Unauthenticated;
      return e;
    }
  }

  Future<FirebaseUser> signInWithCredentials(
      String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _status = Status.Authenticated;
      _user = await _firebaseAuth.currentUser();
      return _user;
    } catch (e) {
      print(e);
      _status = Status.Unauthenticated;
      _user = null;
      return e;
    }
  }

  Future<FirebaseUser> signUp({String email, String password}) async {
    try {
      _status = Status.Authenticating;
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return await _firebaseAuth.currentUser();
    } catch (e) {
      print(e);
      _status = Status.Unauthenticated;
      return e;
    }
  }

  Future<void> signOut() async {
    try {
      print('ingreso al singout');
      _status = Status.Unauthenticated;
      return Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      print('ingreso al sing out');
      print(e);
      _status = Status.Authenticated;
      return e;
    }
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<FirebaseUser> getCurrentUser() async {
    // return UserModel.fromFirebaseUser(await _firebaseAuth.currentUser());
    return await _firebaseAuth.currentUser();
  }

  Future<void> add(UserModel user) async {
    return await userCollection.document(user.id).setData(user.toJson());
  }

  Future<void> delete(UserModel user) async {
    return userCollection.document(user.id).delete();
  }

  Future<UserModel> getByUid(String uid) async {
    final doc = await userCollection.document(uid).get();
    return (doc.exists) ? UserModel.fromSnapshot(doc) : null;
  }

  Future<void> update(UserModel place) {
    return userCollection.document(place.id).updateData(place.toJson());
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _status = Status.Authenticated;
    }
    notifyListeners();
  }
}
