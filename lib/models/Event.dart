class Event {
    String _id;
    String _name;
    String _description;
    String _type;
    Double _ticketPrice;
    Double _longitude;
    Double _latitude;
    Adress _adress;
    String _url;
    Date _strartDate;
    Date _endDate;

    String get id => _id;
    set id(String id) {
      _id = id;
    }

    String get name => _name;
    set name(String name) {
      _name = name;
    }

    String get description => _description;
    set description(String description) {
      _description = description;
    }

    String get type => _type;
    set type(String type) {
      _type = type;
    }

    Double get ticketPrice => _ticketPrice;
    set ticketPrice(Double ticketPrice) {
      _ticketPrice = ticketPrice;
    }

    Double get longitude => _longitude;
    set longitude(Double longitude) {
      _longitude = longitude;
    }

    Double get latitude => _latitude;
    set latitude(Double latitude) {
      _latitude = latitude;
    }

    Adress get adress => _adress;
    set adress(Adress adress) {
      _adress = adress;
    }

    String get url => _url;
    set url(String url) {
      _url = url;
    }

    Date get startDate => _startDate;
    set startDate(Date startDate) {
      _startDate = startDate;
    }

    Date get endDate => _endDate;
    set endDate(Date endDate) {
      _endDate = endDate;
    }
}