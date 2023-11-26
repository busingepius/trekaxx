import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trekax/helpers/style.dart';
import 'package:trekax/controllers/user.dart';
import 'package:trekax/widgets/custom_text.dart';

import 'login.dart';

class RegistrationScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    UserProvider authProvider = Get.put(UserProvider());

    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                color: white,
                height: 50,
              ),
              Container(
                color: white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "images/lg.png",
                      width: 230,
                      height: 120,
                    ),
                  ],
                ),
              ),
              Container(
                height: 40,
                color: white,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: white),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: TextFormField(
                      controller: authProvider.name,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(color: white),
                          border: InputBorder.none,
                          labelStyle: TextStyle(color: white),
                          labelText: "Name",
                          hintText: "eg: Businge Pius",
                          icon: Icon(
                            Icons.person,
                            color: white,
                          )),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: white),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: TextFormField(
                      controller: authProvider.email,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(color: white),
                          border: InputBorder.none,
                          labelStyle: TextStyle(color: white),
                          labelText: "Email",
                          hintText: "e.g: businge@gmail.com",
                          icon: Icon(
                            Icons.email,
                            color: white,
                          )),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: white),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: TextFormField(
                      controller: authProvider.phone,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(color: white),
                          border: InputBorder.none,
                          labelStyle: TextStyle(color: white),
                          labelText: "Phone",
                          hintText: "+256 *********",
                          icon: Icon(
                            Icons.phone,
                            color: white,
                          )),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: white),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: TextFormField(
                      controller: authProvider.password,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(color: white),
                          border: InputBorder.none,
                          labelStyle: TextStyle(color: white),
                          labelText: "Password",
                          hintText: "at least 6 digits",
                          icon: Icon(
                            Icons.lock,
                            color: white,
                          )),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () async {
                    await authProvider.signUp();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: black, borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CustomText(
                            text: "Register",
                            color: white,
                            size: 22,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                child: GestureDetector(
                  onTap: () {
                    Get.to(()=> LoginScreen());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CustomText(
                        text: "Login here",
                        color: Colors.blue,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
