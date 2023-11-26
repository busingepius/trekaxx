import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trekax/helpers/constants.dart';
import 'package:trekax/helpers/style.dart';
import 'package:trekax/controllers/app_state.dart';

import 'custom_text.dart';

class PickupSelectionWidget extends StatelessWidget {

  const PickupSelectionWidget({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AppStateProvider appState =Get.put(AppStateProvider());

    return DraggableScrollableSheet(
      initialChildSize: 0.28,
      minChildSize: 0.28,
      builder: (BuildContext context, ScrollController myscrollController) {
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
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Move the pin to adjust pickup location",
                    size: 12,
                    weight: FontWeight.w300,
                  ),
                ],
              ),
              Divider(),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Container(
                  color: grey.withOpacity(.3),
                  child: TextField(
                    onTap: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      Prediction p = await PlacesAutocomplete.show(
                          context: context,
                          apiKey: GOOGLE_MAPS_API_KEY,
                          mode: Mode.overlay, // Mode.fullscreen
                          // language: "pt",
                          components: [
                            new Component(Component.country,
                                COUNTRY)
                          ]);
                      PlacesDetailsResponse detail =
                          await places.getDetailsByPlaceId(p.placeId);
                      double lat = detail.result.geometry.location.lat;
                      double lng = detail.result.geometry.location.lng;
                      appState.changeRequestedDestination(
                          reqDestination: p.description, lat: lat, lng: lng);
                      appState.updateDestination(destination: p.description);
                      LatLng coordinates = LatLng(lat, lng);
                      appState.setPickCoordinates(coordinates: coordinates);
                      appState.changePickupLocationAddress(
                          address: p.description);
                    },
                    textInputAction: TextInputAction.go,
                    controller: appState.pickupLocationControlelr,
                    cursorColor: Colors.blue.shade900,
                    decoration: InputDecoration(
                      icon: Container(
                        margin: EdgeInsets.only(left: 20, bottom: 15),
                        width: 10,
                        height: 10,
                        child: Icon(
                          Icons.location_on,
                          color: primary,
                        ),
                      ),
                      hintText: "Pick up location",
                      hintStyle: TextStyle(
                          color: black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(15),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      await appState.sendRequest();
                      appState.show.value= 'PAYMENT_METHOD_SELECTION';
                    },
                    // color: black,
                    child: Text(
                      "Confirm Pickup",
                      style: TextStyle(color: white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
