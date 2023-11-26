import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:trekax/helpers/constants.dart';
import 'package:trekax/helpers/style.dart';
import 'package:trekax/models/place.dart';
import 'package:trekax/controllers/application_bloc.dart';
import 'package:trekax/controllers/user.dart';
import 'package:trekax/widgets/custom_text.dart';
import 'package:trekax/controllers/app_state.dart';
import 'package:trekax/widgets/destination_selection.dart';
import 'package:trekax/widgets/drawer.dart';
import 'package:trekax/widgets/driver_found.dart';
import 'package:trekax/widgets/payment_method_selection.dart';
import 'package:trekax/widgets/pickup_selection_widget.dart';
import 'package:trekax/widgets/trip_draggable.dart';

class MapX extends StatelessWidget {
  final Position initialPosition;

  MapX(this.initialPosition);

  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

  // final TextEditingController destinationController = TextEditingController();
  AppStateProvider geoService = Get.put(AppStateProvider());
  UserProvider userProvider = Get.put(UserProvider());
  ApplicationBloc applicationBloc = Get.put(ApplicationBloc());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      // floatingActionButton: FloatingActionButton(
      //   child: Text('cxc'),
      //   onPressed: () {
      //     geoService.show.value = 'DESTINATION_SELECTION';
      //   },
      // ),
      drawer: DrawerA(
        text1: userProvider.userModel.value.name,
        text2: userProvider.userModel.value.email,
        onTap: () {
          userProvider.signOut();
        },
      ),
      body: SafeArea(
        child: Stack(
          children: [
           Positioned.fill(
                child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          initialPosition.latitude, initialPosition.longitude),
                      zoom: 17.0,
                    ),
                    mapType: MapType.normal,
                    zoomControlsEnabled: false,
                    myLocationEnabled: true,
                    tiltGesturesEnabled: false,
                    rotateGesturesEnabled: false,
                    compassEnabled: false,
                    //TODO: FOLLOW UP THIS ON MAP CREATED
                    onMapCreated: (GoogleMapController controller) {
                      geoService.mapcontroller.complete(controller);
                    },
                    markers: geoService.markers,
                    // markers: Set<Marker>.of(applicationBloc.markers),
                    onCameraMove: geoService.onCameraMove,
                    polylines: geoService.poly,
                  ),
              ),
            // Positioned(
            //   top: 3.0,
            //   child: Container(
            //     color: Colors.red,
            //     width: 100.0,
            //     child: TextField(
            //       controller: geoService.destinationController,
            //       textCapitalization: TextCapitalization.words,
            //       decoration: InputDecoration(
            //         hintText: 'Search by City',
            //         suffixIcon: Icon(Icons.search),
            //       ),
            //       onChanged: (value) => applicationBloc.searchPlaces(value),
            //       onTap: () => applicationBloc.clearSelectedLocation(),
            //     ),
            //   ),
            // ),
            // if (applicationBloc.searchResults != null &&
            //     applicationBloc.searchResults.length != 0)
            //   Obx(
            //     () => Container(
            //         height: 300.0,
            //         width: double.infinity,
            //         decoration: BoxDecoration(
            //             color: Colors.black.withOpacity(.6),
            //             backgroundBlendMode: BlendMode.darken)),
            //   ),
            // if (applicationBloc.searchResults != null)
            //   Obx(
            //     () => Container(
            //       height: 600.0,
            //       child: ListView.builder(
            //           itemCount: applicationBloc.searchResults.length,
            //           itemBuilder: (context, index) {
            //             return ListTile(
            //               title: Text(
            //                 applicationBloc.searchResults[index].description,
            //                 style: TextStyle(color: Colors.white),
            //               ),
            //               onTap: () {
            //                 applicationBloc.setSelectedLocation(
            //                     applicationBloc.searchResults[index].placeId);
            //               },
            //             );
            //           }),
            //     ),
            //   ),
            Positioned(
              top: 10,
              left: 15,
              child: IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: /*primary*/ Colors.blue,
                    size: 30,
                  ),
                  onPressed: () {
                    scaffoldState.currentState.openDrawer();
                  }),
            ),
            Obx(() => Positioned(
                child: geoService.show.value == 'DESTINATION_SELECTION'
                    ? DestinationSelectionWidget()
                    : geoService.show.value == 'PICKUP_SELECTION'
                        ? PickupSelectionWidget()
                        : geoService.show.value == 'PAYMENT_METHOD_SELECTION'
                            ? PaymentMethodSelectionWidget()
                            : geoService.show.value == 'DRIVER_FOUND'
                                ? DriverFoundWidget()
                                : geoService.show.value == 'TRIP'
                                    ? TripWidget()
                                    : SizedBox.shrink())),
            ////TODO DRIVER FOUND
            //         Visibility(
            //           visible: geoService.show.value == 'DRIVER_FOUND',
            //           child: Positioned(
            //               top: 60,
            //               left: 15,
            //               child: Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 30),
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: [
            //                     Container(
            //                       child: geoService.driverArrived
            //                           ? Container(
            //                               color: green,
            //                               child: Padding(
            //                                 padding: const EdgeInsets.all(16),
            //                                 child: CustomText(
            //                                   text:
            //                                       "Meet driver at the pick up location",
            //                                   color: Colors.white,
            //                                 ),
            //                               ),
            //                             )
            //                           : Container(
            //                               color: primary,
            //                               child: Padding(
            //                                 padding: const EdgeInsets.all(16),
            //                                 child: CustomText(
            //                                   text:
            //                                       "Meet driver at the pick up location",
            //                                   weight: FontWeight.w300,
            //                                   color: white,
            //                                 ),
            //                               ),
            //                             ),
            //                     ),
            //                   ],
            //                 ),
            //               )),
            //         ),
            // Visibility(
            //   visible: geoService.show.value == 'TRIP',
            //   child: Positioned(
            //       top: 60,
            //       left: MediaQuery.of(context).size.width / 7,
            //       child: Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 30),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Container(
            //               child: Container(
            //                 color: primary,
            //                 child: Padding(
            //                     padding: const EdgeInsets.all(16),
            //                     child: RichText(
            //                         text: TextSpan(children: [
            //                       TextSpan(
            //                           text:
            //                               "You\'ll reach your destination in \n",
            //                           style: TextStyle(
            //                               fontWeight: FontWeight.w300)),
            //                       TextSpan(
            //                           text: geoService
            //                                   .routeModel?.timeNeeded?.text ??
            //                               "",
            //                           style: TextStyle(fontSize: 22)),
            //                     ]))),
            //               ),
            //             ),
            //           ],
            //         ),
            //       )),
            // ),
            // //TODO: ANCHOR Draggable
            // Visibility(
            //        visible: geoService.show.value == 'DESTINATION_SELECTION',
            //        child:  DestinationSelectionWidget()),
            // // //TODO: ANCHOR PICK UP WIDGET
            // Visibility(
            //   visible: geoService.show.value == 'PICKUP_SELECTION',
            //   child: PickupSelectionWidget(),
            // ),
            // // //TODO:  ANCHOR Draggable PAYMENT METHOD
            // Visibility(
            //     visible: geoService.show.value == 'PAYMENT_METHOD_SELECTION',
            //     child: PaymentMethodSelectionWidget()),
            // //TODO:  ANCHOR Draggable DRIVER
            // Visibility(
            //     visible: geoService.show.value == 'DRIVER_FOUND',
            //     child: DriverFoundWidget()),
            // //TODO:  ANCHOR Draggable DRIVER
            // Visibility(
            //     visible: geoService.show.value == 'TRIP',
            //     child: TripWidget()),
          ],
        ),
      ),
    );
  }
// Future<Null> displayPrediction(Prediction p) async {
//   if (p != null) {
//     PlacesDetailsResponse detail =
//         await places.getDetailsByPlaceId(p.placeId);
//
//     var placeId = p.placeId;
//     double lat = detail.result.geometry.location.lat;
//     double lng = detail.result.geometry.location.lng;
//
//     // var address = await Geocoder.local.findAddressesFromQuery(p.description);
//
//     print(lat);
//     print(lng);
//   }
// }
}
