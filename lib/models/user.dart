import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const PHONE = "phone";
  static const VOTES = "votes";
  static const TRIPS = "trips";
  static const RATING = "rating";
  static const TOKEN = "token";

  String? id;
  String? name;
  String? email;
  String? phone;
  String? token;

  int? votes;
  int? trips;
  double? rating;

  UserModel(
      {this.id,
      this.name,
      this.phone,
      this.rating,
      this.token,
      this.trips,
      this.votes,
      this.email});

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    name = snapshot[NAME];
    email = snapshot[EMAIL];
    id = snapshot[ID];
    token = snapshot[TOKEN];

    phone = snapshot[PHONE];
    votes = snapshot[VOTES];
    trips = snapshot[TRIPS];
    rating = snapshot[RATING];
  }
}
