import 'package:trekax/helpers/constants.dart';
import 'package:trekax/models/user.dart';

class UserServices{
  String collection = "users";

  void createUser({String id,  String name,
  String email,
  String phone,
  int votes = 0,
  int trips = 0,
  double rating = 0,
  Map position}) {
    firebaseFiretore.collection(collection).doc(id).set({
      "name": name,
      "id": id,
      "phone": phone,
      "email": email,
      "votes": votes,
      "trips": trips,
      "rating": rating,
      "position": position
    });
  }

  void updateUserData(Map<String, dynamic> values){
    firebaseFiretore.collection(collection).doc(values['id']).update(values);
  }

  Future<UserModel> getUserById(String id) => firebaseFiretore.collection(collection).doc(id).get().then((doc){
    return UserModel.fromSnapshot(doc);
  });

  //TODO:Important to always get the token
  void addDeviceToken({String token, String userId}){
    firebaseFiretore.collection(collection).doc(userId).update({
      "token": token
    });
  }

}