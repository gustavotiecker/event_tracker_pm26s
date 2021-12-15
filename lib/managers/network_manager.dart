import 'dart:convert';
import 'package:event_tracker_pm26s/models/event.dart';
import 'package:http/http.dart';

class NetworkManager {
  NetworkManager._init();
  static final NetworkManager shared = NetworkManager._init();

  final _baseURL = 'https://app.ticketmaster.com/discovery/v2';
  final _apiKey = 'API_KEY';

  Future<List<Event>> fetchEventsNearby(double lat, double lng) async {
    final endPoint = _baseURL +
        '/events?apikey=' +
        _apiKey +
        '&latlong=' +
        lat.toString() +
        ',' +
        lng.toString() +
        '&locale=*';
    Response response = await get(Uri.parse(endPoint));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)["_embedded"]["events"];

      List<Event> events = body
          .map(
            (dynamic item) => Event.fromJson(item),
          )
          .toList();

      return events;
    } else {
      throw Exception('Failed to load events');
    }
  }

  Future<List<Event>> fetchEventsBySearch(String keyword) async {
    final endPoint = _baseURL +
        '/events?apikey=' +
        _apiKey +
        '&keyword=' +
        keyword +
        '&locale=*';
    Response response = await get(Uri.parse(endPoint));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)["_embedded"]["events"];

      List<Event> events = body
          .map(
            (dynamic item) => Event.fromJson(item),
          )
          .toList();

      return events;
    } else {
      throw Exception('Failed to load events');
    }
  }
}
