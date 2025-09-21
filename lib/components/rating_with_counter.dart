import 'package:flutter/material.dart';

import '../constants.dart';

class RatingWithCounter extends StatelessWidget {
  const RatingWithCounter({
    super.key,
    required this.rating,
    required this.numOfRating,
  });

  final double rating;
  final int numOfRating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          rating.toString(),
          style: Theme.of(context)
              .textTheme
              .labelSmall!
              .copyWith(color: titleColor.withOpacity(0.74)),
        ),
        const SizedBox(width: 8),
        Icon(
          Icons.star,
          size: 20,
          color: primaryColor,
        ),
        const SizedBox(width: 8),
        Text("$numOfRating+ Ratings",
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: titleColor.withOpacity(0.74))),
      ],
    );
  }
}
