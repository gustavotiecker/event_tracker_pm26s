import 'dart:async';

import 'package:event_tracker_pm26s/managers/network_manager.dart';
import 'package:event_tracker_pm26s/scenes/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Scenes/placeholder_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Tracker',
      home: HomeMap(),
    );
  }
}

class HomeMap extends StatefulWidget {
  @override
  State<HomeMap> createState() => HomeMapState();
}

class HomeMapState extends State<HomeMap> {
  int _selectedIndex = 0;
  final List _children = [
    HomeMapScreen(),
    PlaceholderWidget(Colors.deepOrange),
    PlaceholderWidget(Colors.green),
    PlaceholderWidget(Colors.red),
  ];
  Completer<GoogleMapController> _controller = Completer();

  void _onItemTapped(int index) {
    // NetworkManager.shared.fetchEventsNearCalgary();
    // return;
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
