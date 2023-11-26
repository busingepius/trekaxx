import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverModel {
  static const ID = "id";
  static const NAME = "name";
  static const LATITUDE = "latitude";
  static const LONGITUDE = "longitude";
  static const HEADING = "heading";
  static const POSITION = "position";
  static const CAR = "car";
  static const PLATE = "plate";
  static const PHOTO = "photo";
  static const RATING = "rating";
  static const VOTES = "votes";
  static const PHONE = "phone";

  String id;
  String name;
  String car;
  String plate;
  String photo;
  String phone;

  double rating;
  int votes;

  DriverPosition position;
  DriverModel({this.votes,this.rating,this.phone,this.name,this.id,this.position,this.photo,this.car,this.plate});
  //
  // String get id => _id;
  //
  // String get name => _name;
  //
  // String get car => _car;
  //
  // String get plate => _plate;
  //
  // String get photo => _photo;
  //
  // String get phone => _phone;
  //
  // DriverPosition get position => _position;
  //
  // double get rating => _rating;
  //
  // int get votes => _votes;

  DriverModel.fromSnapshot(DocumentSnapshot snapshot) {
    name = snapshot.data()[NAME];
    id = snapshot.data()[ID];
    car = snapshot.data()[CAR];
    plate = snapshot.data()[PLATE];
    photo = snapshot.data()[PHOTO];
    phone = snapshot.data()[PHONE];

    rating = snapshot.data()[RATING];
    votes = snapshot.data()[VOTES];
    position = DriverPosition(
        lat: snapshot.data()[POSITION][LATITUDE],
        lng: snapshot.data()[POSITION][LONGITUDE],
        heading: snapshot.data()[POSITION][HEADING]);
  }

  LatLng getPosition() {
    return LatLng(position.lat, position.lng);
  }
}

class DriverPosition {
  final double lat;
  final double lng;
  final double heading;

  DriverPosition({this.lat, this.lng, this.heading});
}
