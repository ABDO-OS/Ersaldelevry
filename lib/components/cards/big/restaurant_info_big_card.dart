import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../price_range_and_food_type.dart';
import '../../rating_with_counter.dart';
import '../../small_dot.dart';
import 'big_card_image_slide.dart';

class RestaurantInfoBigCard extends StatelessWidget {
  final List<String> images, foodType;
  final String name;
  final double rating;
  final int numOfRating, deliveryTime;
  final bool isFreeDelivery;
  final VoidCallback press;

  const RestaurantInfoBigCard({
    super.key,
    required this.name,
    required this.rating,
    required this.numOfRating,
    required this.deliveryTime,
    this.isFreeDelivery = true,
    required this.images,
    required this.foodType,
    required this.press,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // pass list of images here
          BigCardImageSlide(images: images),
          const SizedBox(height: defaultPadding / 2),
          Text(name, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: defaultPadding / 4),
          PriceRangeAndFoodtype(foodType: foodType),
          const SizedBox(height: defaultPadding / 4),
          Row(
            children: [
              RatingWithCounter(rating: rating, numOfRating: numOfRating),
              const SizedBox(width: defaultPadding / 2),
              Icon(
                Icons.access_time,
                size: 20,
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .color!
                    .withOpacity(0.5),
              ),
              const SizedBox(width: 8),
              Text(
                "$deliveryTime Min",
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                child: SmallDot(),
              ),
              Icon(
                Icons.delivery_dining,
                size: 20,
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .color!
                    .withOpacity(0.5),
              ),
              const SizedBox(width: 8),
              Text(isFreeDelivery ? "Free" : "Paid",
                  style: Theme.of(context).textTheme.labelSmall),
            ],
          ),
        ],
      ),
    );
  }
}
