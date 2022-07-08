class PlaceDetails {
  PlaceDetails({
    this.htmlAttributions,
    this.result,
    this.status,
  });

  PlaceDetails.fromJson(dynamic json) {
    if (json['html_attributions'] != null) {
      htmlAttributions = [];
      json['html_attributions'].forEach((v) {
        htmlAttributions?.add(v);
      });
    }
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    status = json['status'];
  }
  List<dynamic>? htmlAttributions;
  Result? result;
  String? status;
  PlaceDetails copyWith({
    List<dynamic>? htmlAttributions,
    Result? result,
    String? status,
  }) =>
      PlaceDetails(
        htmlAttributions: htmlAttributions ?? this.htmlAttributions,
        result: result ?? this.result,
        status: status ?? this.status,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (htmlAttributions != null) {
      map['html_attributions'] = htmlAttributions?.map((v) => v.toJson()).toList();
    }
    if (result != null) {
      map['result'] = result?.toJson();
    }
    map['status'] = status;
    return map;
  }
}

class Result {
  Result({
    this.addressComponents,
    this.adrAddress,
    this.formattedAddress,
    this.geometry,
    this.icon,
    this.iconBackgroundColor,
    this.iconMaskBaseUri,
    this.name,
    this.photos,
    this.placeId,
    this.reference,
    this.types,
    this.url,
    this.utcOffset,
    this.website,
  });

  Result.fromJson(dynamic json) {
    if (json['address_components'] != null) {
      addressComponents = [];
      json['address_components'].forEach((v) {
        addressComponents?.add(AddressComponents.fromJson(v));
      });
    }
    adrAddress = json['adr_address'];
    formattedAddress = json['formatted_address'];
    geometry = json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
    icon = json['icon'];
    iconBackgroundColor = json['icon_background_color'];
    iconMaskBaseUri = json['icon_mask_base_uri'];
    name = json['name'];
    if (json['photos'] != null) {
      photos = [];
      json['photos'].forEach((v) {
        photos?.add(Photos.fromJson(v));
      });
    }
    placeId = json['place_id'];
    reference = json['reference'];
    types = json['types'] != null ? json['types'].cast<String>() : [];
    url = json['url'];
    utcOffset = json['utc_offset'].toDouble();
    website = json['website'];
  }
  List<AddressComponents>? addressComponents;
  String? adrAddress;
  String? formattedAddress;
  Geometry? geometry;
  String? icon;
  String? iconBackgroundColor;
  String? iconMaskBaseUri;
  String? name;
  List<Photos>? photos;
  String? placeId;
  String? reference;
  List<String>? types;
  String? url;
  double? utcOffset;
  String? website;
  Result copyWith({
    List<AddressComponents>? addressComponents,
    String? adrAddress,
    String? formattedAddress,
    Geometry? geometry,
    String? icon,
    String? iconBackgroundColor,
    String? iconMaskBaseUri,
    String? name,
    List<Photos>? photos,
    String? placeId,
    String? reference,
    List<String>? types,
    String? url,
    double? utcOffset,
    String? website,
  }) =>
      Result(
        addressComponents: addressComponents ?? this.addressComponents,
        adrAddress: adrAddress ?? this.adrAddress,
        formattedAddress: formattedAddress ?? this.formattedAddress,
        geometry: geometry ?? this.geometry,
        icon: icon ?? this.icon,
        iconBackgroundColor: iconBackgroundColor ?? this.iconBackgroundColor,
        iconMaskBaseUri: iconMaskBaseUri ?? this.iconMaskBaseUri,
        name: name ?? this.name,
        photos: photos ?? this.photos,
        placeId: placeId ?? this.placeId,
        reference: reference ?? this.reference,
        types: types ?? this.types,
        url: url ?? this.url,
        utcOffset: utcOffset ?? this.utcOffset,
        website: website ?? this.website,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (addressComponents != null) {
      map['address_components'] = addressComponents?.map((v) => v.toJson()).toList();
    }
    map['adr_address'] = adrAddress;
    map['formatted_address'] = formattedAddress;
    if (geometry != null) {
      map['geometry'] = geometry?.toJson();
    }
    map['icon'] = icon;
    map['icon_background_color'] = iconBackgroundColor;
    map['icon_mask_base_uri'] = iconMaskBaseUri;
    map['name'] = name;
    if (photos != null) {
      map['photos'] = photos?.map((v) => v.toJson()).toList();
    }
    map['place_id'] = placeId;
    map['reference'] = reference;
    map['types'] = types;
    map['url'] = url;
    map['utc_offset'] = utcOffset;
    map['website'] = website;
    return map;
  }
}

class Photos {
  Photos({
    this.height,
    this.htmlAttributions,
    this.photoReference,
    this.width,
  });

  Photos.fromJson(dynamic json) {
    height = json['height'].toInt();
    htmlAttributions = json['html_attributions'] != null ? json['html_attributions'].cast<String>() : [];
    photoReference = json['photo_reference'];
    width = json['width'].toInt();
  }
  int? height;
  List<String>? htmlAttributions;
  String? photoReference;
  int? width;
  Photos copyWith({
    int? height,
    List<String>? htmlAttributions,
    String? photoReference,
    int? width,
  }) =>
      Photos(
        height: height ?? this.height,
        width: width ?? this.width,
        htmlAttributions: htmlAttributions ?? this.htmlAttributions,
        photoReference: photoReference ?? this.photoReference,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['height'] = height;
    map['html_attributions'] = htmlAttributions;
    map['photo_reference'] = photoReference;
    map['width'] = width;
    return map;
  }
}

class Geometry {
  Geometry({
    this.location,
    this.viewport,
  });

  Geometry.fromJson(dynamic json) {
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    viewport = json['viewport'] != null ? Viewport.fromJson(json['viewport']) : null;
  }
  Location? location;
  Viewport? viewport;
  Geometry copyWith({
    Location? location,
    Viewport? viewport,
  }) =>
      Geometry(
        location: location ?? this.location,
        viewport: viewport ?? this.viewport,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (location != null) {
      map['location'] = location?.toJson();
    }
    if (viewport != null) {
      map['viewport'] = viewport?.toJson();
    }
    return map;
  }
}

class Viewport {
  Viewport({
    this.northeast,
    this.southwest,
  });

  Viewport.fromJson(dynamic json) {
    northeast = json['northeast'] != null ? Northeast.fromJson(json['northeast']) : null;
    southwest = json['southwest'] != null ? Southwest.fromJson(json['southwest']) : null;
  }
  Northeast? northeast;
  Southwest? southwest;
  Viewport copyWith({
    Northeast? northeast,
    Southwest? southwest,
  }) =>
      Viewport(
        northeast: northeast ?? this.northeast,
        southwest: southwest ?? this.southwest,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (northeast != null) {
      map['northeast'] = northeast?.toJson();
    }
    if (southwest != null) {
      map['southwest'] = southwest?.toJson();
    }
    return map;
  }
}

class Southwest {
  Southwest({
    this.lat,
    this.lng,
  });

  Southwest.fromJson(dynamic json) {
    lat = json['lat'].toDouble();
    lng = json['lng'].toDouble();
  }
  double? lat;
  double? lng;
  Southwest copyWith({
    double? lat,
    double? lng,
  }) =>
      Southwest(
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

class Northeast {
  Northeast({
    this.lat,
    this.lng,
  });

  Northeast.fromJson(dynamic json) {
    lat = json['lat'].toDouble();
    lng = json['lng'].toDouble();
  }
  double? lat;
  double? lng;
  Northeast copyWith({
    double? lat,
    double? lng,
  }) =>
      Northeast(
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = lat?.toDouble();
    map['lng'] = lng?.toDouble();
    return map;
  }
}

class Location {
  Location({
    this.lat,
    this.lng,
  });

  Location.fromJson(dynamic json) {
    lat = json['lat'].toDouble();
    lng = json['lng'].toDouble();
  }
  double? lat;
  double? lng;
  Location copyWith({
    double? lat,
    double? lng,
  }) =>
      Location(
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = lat?.toDouble();
    map['lng'] = lng?.toDouble();
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
