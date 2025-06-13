// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PlaceLocation {
  final String address;
  final String latitude;
  final String longitude;

  PlaceLocation(
    this.address, {
    required this.latitude,
    required this.longitude,
  });

  PlaceLocation copyWith({
    String? address,
    String? latitude,
    String? longitude,
  }) {
    return PlaceLocation(
      address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory PlaceLocation.fromMap(Map<String, dynamic> map) {
    return PlaceLocation(
      map['address'] as String,
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaceLocation.fromJson(String source) =>
      PlaceLocation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PlaceLocation(address: $address, latitude: $latitude, longitude: $longitude)';

  @override
  bool operator ==(covariant PlaceLocation other) {
    if (identical(this, other)) return true;

    return other.address == address &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode => address.hashCode ^ latitude.hashCode ^ longitude.hashCode;
}
