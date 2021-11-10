import 'address.dart';

class Event {
  String? _id;
  String? _name;
  String? _description;
  String? _type;
  double? _ticketPrice;
  double? _longitude;
  double? _latitude;
  Address? _address;
  String? _url;
  DateTime? _startDate;
  DateTime? _endDate;

  String? get id => _id;
  set id(String? id) {
    _id = id;
  }

  String? get name => _name;
  set name(String? name) {
    _name = name;
  }

  String? get description => _description;
  set description(String? description) {
    _description = description;
  }

  String? get type => _type;
  set type(String? type) {
    _type = type;
  }

  double? get ticketPrice => _ticketPrice;
  set ticketPrice(double? ticketPrice) {
    _ticketPrice = ticketPrice;
  }

  double? get longitude => _longitude;
  set longitude(double? longitude) {
    _longitude = longitude;
  }

  double? get latitude => _latitude;
  set latitude(double? latitude) {
    _latitude = latitude;
  }

  Address? get address => _address;
  set address(Address? address) {
    _address = address;
  }

  String? get url => _url;
  set url(String? url) {
    _url = url;
  }

  DateTime? get startDate => _startDate;
  set startDate(DateTime? startDate) {
    _startDate = startDate;
  }

  DateTime? get endDate => _endDate;
  set endDate(DateTime? endDate) {
    _endDate = endDate;
  }
}
