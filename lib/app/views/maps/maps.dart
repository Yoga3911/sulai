import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sulai/app/view_model/location.dart';

class MyMaps extends StatefulWidget {
  const MyMaps({Key? key}) : super(key: key);

  @override
  State<MyMaps> createState() => MyMapsState();
}

class MyMapsState extends State<MyMaps> {
  final Completer<GoogleMapController> _controller = Completer();

  CameraPosition currenLocation() {
    final location = Provider.of<MyLocation>(context);
    return CameraPosition(
    target: LatLng(location.lat, location.long),
    zoom: 14.4746,
  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: currenLocation(),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
