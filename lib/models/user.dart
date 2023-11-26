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

  String id;
  String name;
  String email;
  String phone;
  String token;

  int votes;
  int trips;
  double rating;

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
    name = snapshot.data()[NAME];
    email = snapshot.data()[EMAIL];
    id = snapshot.data()[ID];
    token = snapshot.data()[TOKEN];

    phone = snapshot.data()[PHONE];
    votes = snapshot.data()[VOTES];
    trips = snapshot.data()[TRIPS];
    rating = snapshot.data()[RATING];
  }
}
