import 'package:cloud_firestore/cloud_firestore.dart';

class RideRequestModel{
 static const ID = "id";
 static const USERNAME = "username";
 static const USER_ID = "userId";
 static const DRIVER_ID = "driverId";
 static const STATUS = "status";
 static const POSITION = "position";
 static const DESTINATION = "destination";

 String id;
 String username;
 String userId;
 String driverId;
 String status;
 Map position;
 Map destination;

 // String get id => _id;
 // String get username => _username;
 // String get userId => _userId;
 // String get driverId => _driverId;
 // String get status => _status;
 // Map get position => _position;
 // Map get destination => _destination;
 RideRequestModel({this.position,this.id,this.destination,this.userId,this.username,this.driverId,this.status});
 RideRequestModel.fromSnapshot(DocumentSnapshot snapshot){
  id = snapshot.data()[ID];
  username = snapshot.data()[USERNAME];
  userId = snapshot.data()[USER_ID];
  driverId = snapshot.data()[DRIVER_ID];
  status = snapshot.data()[STATUS];
  position = snapshot.data()[POSITION];
  destination = snapshot.data()[DESTINATION];
 }

}