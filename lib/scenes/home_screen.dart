import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class HomeMapScreen extends StatefulWidget {
  @override
  State<HomeMapScreen> createState() => HomeMapScreenState();
}

class HomeMapScreenState extends State<HomeMapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  Position? _currentPosition;
  CameraPosition? _cameraPosition;

  @override
  void initState() {
    super.initState();
    _determinePosition().then((value) {
      setState(() {
        _currentPosition = value;
        _cameraPosition = CameraPosition(
          target:
              LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          zoom: 14.4746,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: _createBody());
  }

  Widget _createBody() {
    if (_cameraPosition == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _cameraPosition!,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
