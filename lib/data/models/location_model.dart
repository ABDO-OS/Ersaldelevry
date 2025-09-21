import 'package:equatable/equatable.dart';

class LocationModel extends Equatable {
  final double latitude;
  final double longitude;
  final String? address;
  final String? city;
  final String? country;
  final DateTime timestamp;

  const LocationModel({
    required this.latitude,
    required this.longitude,
    this.address,
    this.city,
    this.country,
    required this.timestamp,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'city': city,
      'country': country,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  LocationModel copyWith({
    double? latitude,
    double? longitude,
    String? address,
    String? city,
    String? country,
    DateTime? timestamp,
  }) {
    return LocationModel(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      city: city ?? this.city,
      country: country ?? this.country,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  List<Object?> get props => [
        latitude,
        longitude,
        address,
        city,
        country,
        timestamp,
      ];
}
