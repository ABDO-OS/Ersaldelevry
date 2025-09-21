import 'package:equatable/equatable.dart';

class RestaurantModel extends Equatable {
  final String id;
  final String name;
  final String location;
  final String? image;
  final double rating;
  final int numOfRating;
  final int deliveryTime;
  final bool isFreeDelivery;
  final List<String> foodTypes;
  final String priceRange;

  const RestaurantModel({
    required this.id,
    required this.name,
    required this.location,
    this.image,
    required this.rating,
    required this.numOfRating,
    required this.deliveryTime,
    this.isFreeDelivery = true,
    required this.foodTypes,
    required this.priceRange,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'] as String,
      name: json['name'] as String,
      location: json['location'] as String,
      image: json['image'] as String?,
      rating: (json['rating'] as num).toDouble(),
      numOfRating: json['numOfRating'] as int,
      deliveryTime: json['deliveryTime'] as int,
      isFreeDelivery: json['isFreeDelivery'] as bool? ?? true,
      foodTypes: List<String>.from(json['foodTypes'] as List),
      priceRange: json['priceRange'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'image': image,
      'rating': rating,
      'numOfRating': numOfRating,
      'foodTypes': foodTypes,
      'deliveryTime': deliveryTime,
      'isFreeDelivery': isFreeDelivery,
      'priceRange': priceRange,
    };
  }

  RestaurantModel copyWith({
    String? id,
    String? name,
    String? location,
    String? image,
    double? rating,
    int? numOfRating,
    int? deliveryTime,
    bool? isFreeDelivery,
    List<String>? foodTypes,
    String? priceRange,
  }) {
    return RestaurantModel(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      numOfRating: numOfRating ?? this.numOfRating,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      isFreeDelivery: isFreeDelivery ?? this.isFreeDelivery,
      foodTypes: foodTypes ?? this.foodTypes,
      priceRange: priceRange ?? this.priceRange,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        location,
        image,
        rating,
        numOfRating,
        deliveryTime,
        isFreeDelivery,
        foodTypes,
        priceRange,
      ];
}
