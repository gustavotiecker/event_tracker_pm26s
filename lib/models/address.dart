class Address {
  static const tableName = 'address';
  static const fieldId = 'id';
  static const fieldPostalCode = 'postalCode';
  static const fieldCountry = 'country';
  static const fieldState = 'state';
  static const fieldCity = 'city';
  static const fieldStreet = 'street';

  int? id;
  String? postalCode;
  String? country;
  String? state;
  String? city;
  String? street;

  Address(
      {this.id,
      this.postalCode,
      this.country,
      this.state,
      this.city,
      this.street});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        id: 0,
        postalCode: json["_embedded"]["venues"][0]["postalCode"]?.toString(),
        country:
            json["_embedded"]["venues"][0]["country"]["name"]?.toString() ?? "",
        state:
            json["_embedded"]["venues"][0]["state"]?["name"]?.toString() ?? "",
        city: json["_embedded"]["venues"][0]["city"]["name"]?.toString() ?? "",
        street:
            json["_embedded"]["venues"][0]["address"]?["line1"]?.toString() ??
                "");
  }

  Map<String, dynamic> toMap() => {
        fieldId: id,
        fieldPostalCode: postalCode,
        fieldCountry: country,
        fieldState: state,
        fieldCity: city,
        fieldStreet: street,
      };

  factory Address.fromMap(Map<String, dynamic> map) => Address(
        id: map[fieldId] is int ? map[fieldId] : null,
        postalCode: map[fieldPostalCode] is String ? map[fieldPostalCode] : '',
        country: map[fieldCountry] is String ? map[fieldCountry] : null,
        state: map[fieldState] is String ? map[fieldState] : null,
        city: map[fieldCity] is double ? map[fieldCity] : '',
        street: map[fieldStreet] is double ? map[fieldStreet] : null,
      );
}
