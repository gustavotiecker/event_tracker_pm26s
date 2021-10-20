class Address {
  String? _postalCode;
  String? _country;
  String? _state;
  String? _city;
  String? _street;

  String? get postalCode => _postalCode;

  set postalCode(String? postalCode) {
    _postalCode = postalCode;
  }

  String? get country => _country;

  set country(String? country) {
    _country = country;
  }

  String? get state => _state;

  set state(String? state) {
    _state = state;
  }

  String? get city => _city;

  set city(String? city) {
    _city = city;
  }

  String? get street => _street;

  set street(String? street) {
    _street = street;
  }
}
