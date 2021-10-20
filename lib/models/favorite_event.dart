import 'event.dart';

class FavoriteEvent {
  Event? _event;

  Event? get event => _event;

  set event(Event? event) {
    _event = event;
  }
}
