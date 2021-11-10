import 'address.dart';

class Event {
  String? id;
  String? name;
  String? description;
  String? type;
  double? ticketPrice;
  double? longitude;
  double? latitude;
  Address? address;
  String? url;
  String? startDate;

  Event(
      {this.id,
      this.name,
      this.description,
      this.type,
      this.ticketPrice,
      this.longitude,
      this.latitude,
      this.address,
      this.url,
      this.startDate});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description']?.toString() ?? json['info']?.toString(),
      type: json['type'] as String,
      ticketPrice: double.tryParse(
          json["priceRanges"]?.elementAt(0)["min"]?.toString() ?? ""),
      longitude: double.tryParse(
          json["_embedded"]["venues"][0]["location"]["longitude"]),
      latitude: double.tryParse(
          json["_embedded"]["venues"][0]["location"]["latitude"]),
      address: new Address.fromJson(json),
      url: json['url'] as String,
      startDate: json["dates"]["start"]["dateTime"]?.toString(),
    );
  }
}
