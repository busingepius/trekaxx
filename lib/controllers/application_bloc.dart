import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trekax/models/geometry.dart';
import 'package:trekax/models/location.dart';
import 'package:trekax/models/place.dart';
import 'package:trekax/models/place_search.dart';
import 'package:trekax/services/geolocator_service.dart';
import 'package:trekax/services/marker_service.dart';
import 'package:trekax/services/places_service.dart';

class ApplicationBloc /*with ChangeNotifier*/extends GetxController {
  final geoLocatorService = GeolocatorService();
  final placesService = PlacesService();
  final markerService = MarkerService();

  //Variables
  Position currentLocation;
  RxList<PlaceSearch> searchResults;
  StreamController<Place> selectedLocation = StreamController<Place>();
  StreamController<LatLngBounds> bounds = StreamController<LatLngBounds>();
  Place selectedLocationStatic;
  String placeType;
  List<Place> placeResults;
  List<Marker> markers = List<Marker>();


  ApplicationBloc() {
    setCurrentLocation();
  }


  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    selectedLocationStatic = Place(name: null,
      geometry: Geometry(location: Location(
          lat: currentLocation.latitude, lng: currentLocation.longitude),),);
    /*notifyListeners()*/update();
  }

  searchPlaces(String searchTerm) async {
    searchResults.value = await placesService.getAutocomplete(searchTerm);
    /*notifyListeners()*/update();
  }


  setSelectedLocation(String placeId) async {
    var sLocation = await placesService.getPlace(placeId);
    selectedLocation.add(sLocation);
    selectedLocationStatic = sLocation;
    searchResults = null;
    /*notifyListeners()*/update();
  }

  clearSelectedLocation() {
    selectedLocation.add(null);
    selectedLocationStatic = null;
    searchResults = null;
    placeType = null;
    /*notifyListeners()*/update();
  }

  togglePlaceType(String value, bool selected) async {
    if (selected) {
      placeType = value;
    } else {
      placeType = null;
    }

    if (placeType != null) {
      var places = await placesService.getPlaces(
          selectedLocationStatic.geometry.location.lat,
          selectedLocationStatic.geometry.location.lng, placeType);
      markers= [];
      if (places.length > 0) {
        var newMarker = markerService.createMarkerFromPlace(places[0],false);
        markers.add(newMarker);
      }

      var locationMarker = markerService.createMarkerFromPlace(selectedLocationStatic,true);
      markers.add(locationMarker);

      var _bounds = markerService.bounds(Set<Marker>.of(markers));
      bounds.add(_bounds);

      /*notifyListeners()*/update();
    }
  }



@override
void dispose() {
  selectedLocation.close();
  bounds.close();
  super.dispose();
}}
