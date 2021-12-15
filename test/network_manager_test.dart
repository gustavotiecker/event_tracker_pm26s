import 'package:event_tracker_pm26s/managers/network_manager.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final network = NetworkManager.shared;
  test("fetchEventsNearby: deve retornar uma lista de eventos ", () async {
    final list = await network.fetchEventsNearby(34.0522342, -118.2436849);
    expect(list.isNotEmpty, equals(true));
    expect(list.first.name!.isNotEmpty, equals(true));
  });


  test("fetchEventsBySearch: deve retornar uma lista de eventos  comp palavras chave", () async {
    final list = await network.fetchEventsBySearch("foo");
    print(list.first.name);
    expect(list.isNotEmpty, equals(true));
  });


}
