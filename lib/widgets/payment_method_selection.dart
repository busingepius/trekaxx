import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:trekax/helpers/style.dart';
import 'package:trekax/controllers/app_state.dart';
import 'package:trekax/controllers/user.dart';

import 'custom_text.dart';

class PaymentMethodSelectionWidget extends StatelessWidget {
  const PaymentMethodSelectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppStateProvider appState = Get.put(AppStateProvider());
    UserProvider userProvider = Get.put(UserProvider());

    return DraggableScrollableSheet(
        initialChildSize: 0.3,
        minChildSize: 0.3,
        maxChildSize: 0.3,
        builder: (BuildContext context, myscrollController) {
          return Container(
            decoration: BoxDecoration(color: white,
//                        borderRadius: BorderRadius.only(
//                            topLeft: Radius.circular(20),
//                            topRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      color: grey.withOpacity(.8),
                      offset: Offset(3, 2),
                      blurRadius: 7)
                ]),
            child: ListView(
              controller: myscrollController,
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomText(
                    text: "How do you want to pay,\nUGX ${appState.ridePrice}",
                    size: 24,
                    weight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.blue.withOpacity(0.3),
                                width: 1.5)),
                        child: TextButton.icon(
                            onPressed: () {
                              Get.snackbar('Alert!!!', "Method not available!");
                            },
                            icon: Icon(Icons.credit_card),
                            label: CustomText(text: "With Card")),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.blueAccent.withOpacity(0.1),
                            border: Border.all(color: Colors.blue, width: 1.5)),
                        child: TextButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.monetization_on),
                            label: CustomText(text: "With Cash")),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                appState.lookingForDriver
                    ? Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: Container(
                          color: white,
                          child: ListTile(
                            title: SpinKitWave(
                              color: black,
                              size: 30,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 15.0,
                            right: 15.0,
                          ),
                          child: ElevatedButton(
                            onPressed: () async {
                              appState.requestDriver(
                                  distance:
                                      appState.routeModel!.distance!.toJson(),
                                  user: userProvider.userModel.value,
                                  lat: appState.pickupCoordinates!.latitude,
                                  lng: appState.pickupCoordinates!.longitude,
                                  context: context);
                              appState.changeMainContext(context);

                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              20.0)), //this right here
                                      child: Container(
                                        height: 200,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SpinKitWave(
                                                color: black,
                                                size: 30,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CustomText(
                                                      text:
                                                          "Looking for a driver"),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              LinearProgressIndicator(),
                                              //TODO: THE LINEARPERCENTINDICATOR WAS DELETED
                                              // LinearPercentIndicator(
                                              //   lineHeight: 4,
                                              //   animation: true,
                                              //   animationDuration: 100000,
                                              //   percent: 1,
                                              //   backgroundColor: Colors.grey
                                              //       .withOpacity(0.2),
                                              //   progressColor:
                                              //       Colors.deepOrange,
                                              // ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        appState
                                                            .cancelRequest();
                                                        Get.snackbar('Alert!!!',
                                                            "Request cancelled!");
                                                      },
                                                      child: CustomText(
                                                        text: "Cancel Request",
                                                        color:
                                                            Colors.deepOrange,
                                                      )),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                            // color: black,
                            child: Text(
                              "Request",
                              style: TextStyle(color: white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          );
        });
  }
}
