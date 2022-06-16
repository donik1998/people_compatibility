import 'dart:convert';

CityGeocodeResponse cityGeocodeResponseFromJson(String str) => CityGeocodeResponse.fromJson(json.decode(str));
String cityGeocodeResponseToJson(CityGeocodeResponse data) => json.encode(data.toJson());

class CityGeocodeResponse {
  CityGeocodeResponse({
    this.results,
    this.status,
  });

  CityGeocodeResponse.fromJson(dynamic json) {
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
    status = json['status'];
  }
  List<Results>? results;
  String? status;
  CityGeocodeResponse copyWith({
    List<Results>? results,
    String? status,
  }) =>
      CityGeocodeResponse(
        results: results ?? this.results,
        status: status ?? this.status,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    return map;
  }
}

Results resultsFromJson(String str) => Results.fromJson(json.decode(str));
String resultsToJson(Results data) => json.encode(data.toJson());

class Results {
  Results({
    this.addressComponents,
    this.formattedAddress,
    this.geometry,
    this.placeId,
    this.types,
  });

  Results.fromJson(dynamic json) {
    if (json['address_components'] != null) {
      addressComponents = [];
      json['address_components'].forEach((v) {
        addressComponents?.add(AddressComponents.fromJson(v));
      });
    }
    formattedAddress = json['formatted_address'];
    geometry = json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
    placeId = json['place_id'];
    types = json['types'] != null ? json['types'].cast<String>() : [];
  }
  List<AddressComponents>? addressComponents;
  String? formattedAddress;
  Geometry? geometry;
  String? placeId;
  List<String>? types;
  Results copyWith({
    List<AddressComponents>? addressComponents,
    String? formattedAddress,
    Geometry? geometry,
    String? placeId,
    List<String>? types,
  }) =>
      Results(
        addressComponents: addressComponents ?? this.addressComponents,
        formattedAddress: formattedAddress ?? this.formattedAddress,
        geometry: geometry ?? this.geometry,
        placeId: placeId ?? this.placeId,
        types: types ?? this.types,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (addressComponents != null) {
      map['address_components'] = addressComponents?.map((v) => v.toJson()).toList();
    }
    map['formatted_address'] = formattedAddress;
    if (geometry != null) {
      map['geometry'] = geometry?.toJson();
    }
    map['place_id'] = placeId;
    map['types'] = types;
    return map;
  }
}

Geometry geometryFromJson(String str) => Geometry.fromJson(json.decode(str));
String geometryToJson(Geometry data) => json.encode(data.toJson());

class Geometry {
  Geometry({
    this.location,
    this.locationType,
  });

  Geometry.fromJson(dynamic json) {
    location = json['location'] != null ? CityLocation.fromJson(json['location']) : null;
    locationType = json['location_type'];
  }
  CityLocation? location;
  String? locationType;
  Geometry copyWith({
    CityLocation? location,
    String? locationType,
  }) =>
      Geometry(
        location: location ?? this.location,
        locationType: locationType ?? this.locationType,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (location != null) {
      map['location'] = location?.toJson();
    }
    map['location_type'] = locationType;

    return map;
  }
}

class CityLocation {
  CityLocation({
    this.lat,
    this.lng,
  });

  CityLocation.fromJson(dynamic json) {
    lat = json['lat'];
    lng = json['lng'];
  }
  double? lat;
  double? lng;
  CityLocation copyWith({
    double? lat,
    double? lng,
  }) =>
      CityLocation(
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = lat;
    map['lng'] = lng;
    return map;
  }
}

class AddressComponents {
  AddressComponents({
    this.longName,
    this.shortName,
    this.types,
  });

  AddressComponents.fromJson(dynamic json) {
    longName = json['long_name'];
    shortName = json['short_name'];
    types = json['types'] != null ? json['types'].cast<String>() : [];
  }
  String? longName;
  String? shortName;
  List<String>? types;
  AddressComponents copyWith({
    String? longName,
    String? shortName,
    List<String>? types,
  }) =>
      AddressComponents(
        longName: longName ?? this.longName,
        shortName: shortName ?? this.shortName,
        types: types ?? this.types,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['long_name'] = longName;
    map['short_name'] = shortName;
    map['types'] = types;
    return map;
  }
}
