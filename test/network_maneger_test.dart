import 'package:event_tracker_pm26s/managers/network_manager.dart';
import 'package:flutter_test/flutter_test.dart';
void main(){
 final network = NetworkManager.shared;
  test("deve retornar uma lista de eventos ",() async{
    final list = await network.fetchEventsNearCalgary();
    expect(list.isNotEmpty, equals(true));
    expect(list.first.name!.isNotEmpty, equals(true));

  });


}