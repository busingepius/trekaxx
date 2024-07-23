import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trekax/helpers/constants.dart';

class RideRequestServices {
  String collection = "requests";

  void createRideRequest({
    String? id,
    String? userId,
    String? username,
    Map<String, dynamic>? destination,
    Map<String, dynamic>? position,
    Map? distance,
  }) {
    firebaseFiretore.collection(collection).doc(id).set({
      "username": username,
      "id": id,
      "userId": userId,
      "driverId": "",
      "position": position,
      "status": 'pending',
      "destination": destination,
      "distance": distance
    });
  }

  void updateRequest(Map<String, dynamic> values) {
    firebaseFiretore
        .collection(collection)
        .doc(values['id'])
        .update(values);
  }

  Stream<DocumentSnapshot> requestStream({String? id}) {
    //changed return type from QuerySnapshot to DocumentSnapshot
    CollectionReference reference = FirebaseFirestore.instance.collection(collection);
    return reference.doc(id).snapshots();/*changed this from reference.snapshot*/
  }
}
