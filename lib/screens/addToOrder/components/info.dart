import 'package:flutter/material.dart';

import '../../../components/price_range_and_food_type.dart';
import '../../../constants.dart';

class Info extends StatelessWidget {
  const Info({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1.33,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: const Center(
              child: Icon(
                Icons.restaurant,
                size: 80,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        const SizedBox(height: defaultPadding),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Cookie Sandwich",
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(
                "Shortbread, chocolate turtle cookies, and red velvet. 8 ounces cream cheese, softened.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              const PriceRangeAndFoodtype(
                foodType: ["Chinese", "American", "Deshi food"],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
