class Address {
  String? postalCode;
  String? country;
  String? state;
  String? city;
  String? street;

  Address({this.postalCode, this.country, this.state, this.city, this.street});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        postalCode: json["_embedded"]["venues"][0]["postalCode"]?.toString(),
        country:
            json["_embedded"]["venues"][0]["country"]["name"]?.toString() ?? "",
        state:
            json["_embedded"]["venues"][0]["state"]["name"]?.toString() ?? "",
        city: json["_embedded"]["venues"][0]["city"]["name"]?.toString() ?? "",
        street:
            json["_embedded"]["venues"][0]["address"]["line1"]?.toString() ??
                "");
  }
}
