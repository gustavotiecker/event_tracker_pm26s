import 'dart:async';

import 'package:event_tracker_pm26s/managers/network_manager.dart';
import 'package:event_tracker_pm26s/scenes/event_details.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:event_tracker_pm26s/models/event.dart';
import 'package:geolocator/geolocator.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HomeMapScreen extends StatefulWidget {
  @override
  State<HomeMapScreen> createState() => HomeMapScreenState();
}

class HomeMapScreenState extends State<HomeMapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  Position? _currentPosition;
  CameraPosition? _cameraPosition;
  late BitmapDescriptor customIcon;
  final Set<Marker> listMarkers = {};
  late List<Event> _events;

  @override
  void initState() {
    super.initState();
    setCustomMarker();
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
    NetworkManager.shared.fetchEventsNearCalgary().then((value) {
      setState(() {
        _events = value;
        fillMarkersList();
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
      markers: listMarkers,
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

  void setCustomMarker() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'images/custom_marker.png');
  }

  void fillMarkersList() {
    for (var event in _events) {
      listMarkers.add(
        Marker(
            markerId: MarkerId(_events.indexOf(event).toString()),
            position: LatLng(event.latitude!, event.longitude!),
            infoWindow: InfoWindow(title: event.name),
            icon: BitmapDescriptor.defaultMarker,
            onTap: () {
              showMaterialModalBottomSheet(
                context: context,
                builder: (context) => EventDetails(event: event),
              );
            }),
      );
    }
  }
}
