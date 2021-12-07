import 'address.dart';

class Event {
  static const tableName = 'event';
  static const fieldId = '_id';
  static const fieldName = 'name';
  static const fieldDescription = 'description';
  static const fieldType = 'type';
  static const fieldTicketPrice = 'ticketPrice';
  static const fieldLongitude = 'longitude';
  static const fieldLatitude = 'latitude';
  static const fieldUrl = 'url';
  static const fieldStartDate = 'startDate';
  static const fieldImageURL = 'imageURL';

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
  String? imageURL;

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
      this.startDate,
      this.imageURL});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        id: json['id'] as String,
        name: json['name'] as String,
        description:
            json['description']?.toString() ?? json['info']?.toString(),
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
        imageURL: json['images'][0]['url']);
  }

  Map<String, dynamic> toMap() => {
        fieldId: id,
        fieldName: name,
        fieldDescription: description,
        fieldType: type,
        fieldTicketPrice: ticketPrice,
        fieldLongitude: longitude,
        fieldLatitude: latitude,
        fieldUrl: url,
        fieldStartDate: startDate,
        fieldImageURL: imageURL,
      };

  factory Event.fromMap(Map<String, dynamic> map) => Event(
        id: map[fieldId] is String ? map[fieldId] : null,
        name: map[fieldName] is String ? map[fieldName] : '',
        description:
            map[fieldDescription] is String ? map[fieldDescription] : null,
        type: map[fieldType] is String ? map[fieldType] : null,
        ticketPrice:
            map[fieldTicketPrice] is double ? map[fieldTicketPrice] : 0.0,
        longitude: map[fieldLongitude] is double ? map[fieldLongitude] : null,
        latitude: map[fieldLatitude] is double ? map[fieldLatitude] : null,
        url: map[fieldUrl] is String ? map[fieldUrl] : '',
        startDate: map[fieldStartDate] is String ? map[fieldStartDate] : null,
        imageURL: map[fieldImageURL] is String ? map[fieldImageURL] : null,
      );
}
