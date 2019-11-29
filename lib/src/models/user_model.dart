import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String email;
  final String fcmToken;

  UserModel({
    this.id,
    this.email,
    this.fcmToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);


static UserModel fromSnapshot(DocumentSnapshot snap) {
    return UserModel(
      id: snap.documentID,
      email: snap.data['email'],
      fcmToken: snap.data['fcmToken'],
    );
  }

  static UserModel fromFirebaseUser(FirebaseUser user) {
    return UserModel(
      id: user.uid,
      email: user.email,
      fcmToken: user.uid,
    );
  }
   @override
   String toString() {
   return '$id $email';
    }

}