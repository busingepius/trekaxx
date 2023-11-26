import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:trekax/controllers/app_state.dart';
import 'package:trekax/screens/splash.dart';

import 'map.dart';

class TransitionScreen extends StatelessWidget {
  TransitionScreen({Key key}) : super(key: key);
  AppStateProvider geoService = Get.put( AppStateProvider());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: geoService.getInitialLocation(),
          builder: (
            context,
            AsyncSnapshot<Position> position,
          ) {
            //TODO: PANEL BEAT THIS FOR SMOOTH PERMISSIONS
            print('${position.data}xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
            return (position.hasData)
                  ? MapX(position.requireData)
                  :
                Splash();
          }),
    );
  }
}
