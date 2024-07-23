import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trekax/helpers/constants.dart';
import 'package:trekax/helpers/showLoadind.dart';
import 'package:trekax/models/user.dart';
import 'package:trekax/screens/login.dart';
import 'package:trekax/screens/transition.dart';
import 'package:trekax/services/user.dart';
import 'package:get/get.dart';



class UserProvider extends GetxController{
  // static const LOGGED_IN = "loggedIn";
  // static const ID = "id";

  // User _user;
  // UserModel _userModel;
  Rx<User?>? firebaseUser;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  // String usersCollection = "users";
  Rx<UserModel> userModel = UserModel().obs;
  // public variables
  final formkey = GlobalKey<FormState>();
  Rx<UserServices> userServices = UserServices().obs;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User>(auth!.currentUser!);
    firebaseUser?.bindStream(auth!.userChanges());
    ever(firebaseUser!, _setInitialScreen);
  }

  _setInitialScreen(User? user) async {
    if (user == null) {
      print('gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg');
      Get.offAll(() => LoginScreen());
    } else {
      userModel.value = await userServices.value.getUserById(user.uid);
      // userModel.bindStream(listenToUser());
      Get.offAll(() => TransitionScreen());
    }
  }

//  getter
//   UserModel get userModel => _userModel;
  // Status get status => _status;
  // User get user => _user;


  // TextEditingController email = TextEditingController();
  // TextEditingController password = TextEditingController();
  // TextEditingController name = TextEditingController();
  // TextEditingController phone = TextEditingController();

  // UserProvider.initialize(){
  //   _fireSetUp();
  // }
  //
  // _fireSetUp() async {
  //   await initialization.then((value) {
  //     auth.authStateChanges().listen(_onStateChanged);
  //   });
  // }

  // Future<bool> signIn()async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   try{
  //     // _status = Status.Authenticating;
  //     update();
  //     await auth
  //         .signInWithEmailAndPassword(
  //         email: email.text.trim(), password: password.text.trim())
  //         .then((value) async {
  //       // await prefs.setString(ID, value.user.uid);
  //       // await prefs.setBool(LOGGED_IN, true);
  //       _userModel = await userServices.value.getUserById(value.user.uid);
  //       // _status = Status.Authenticated;
  //     });
  //     // return prefs.getBool(LOGGED_IN);
  //  }catch(e){
  //    // _status = Status.Unauthenticated;
  //    update();
  //    print(e.toString());
  //    return false;
  //  }
  // }

  // _onStateChanged(User firebaseUser) async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if(firebaseUser == null){
  //     // _status = Status.Unauthenticated;
  //   }else{
  //     _user = firebaseUser;
  //     // await prefs.setString(ID, firebaseUser.uid);
  //     // _status = Status.Authenticated;
  //     _userModel = await userServices.value.getUserById(_user.uid).then((value) {
  //       // _status = Status.Authenticated;
  //       return value;
  //     });
  //   }
  //   update();
  // }

  // Future<void> reloadUserModel()async{
  //   _userModel = await userServices.value.getUserById(user.uid);
  //   update();
  // }

  // updateUserData(Map<String, dynamic> data) async {
  //   userServices.value.updateUserData(data);
  // }

  // saveDeviceToken()async{
  //   String deviceToken = await fcm.getToken();
  //   if(deviceToken != null){
  //     userServices.value.addDeviceToken(
  //         userId: user.uid,
  //         token: deviceToken
  //     );
  //   }
  // }


  void signIn() async {
    try {
      showLoading();
      await auth!
          .signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      )
          .then((result) {
        dismissLoadingWidget();
      });
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Sign In Failed", "Try again");
    }
  }


  void signUp() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      showLoading();
      await auth!
          .createUserWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim())
          .then((result)async {
        // String _deviceToken = await fcm.getToken();
        userServices.value.createUser(
          id: result.user!.uid,
          name: name.text.trim(),
          email: email.text.trim(),
          phone: phone.text.trim(),
          // token: _deviceToken,
        );
        dismissLoadingWidget();
      });
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Sign Up Failed", "Try again later");
    }
  }

  void signOut() async {
    try{
      auth!.signOut();
    }catch(e){
      Get.snackbar("Sign Out Failed", "Try again");
    }
  }

  void clearController(){
    name.text = "";
    password.text = "";
    email.text = "";
    phone.text = "";
  }
}