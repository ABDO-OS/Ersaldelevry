import 'package:flutter/material.dart';

class BigCardImage extends StatelessWidget {
  const BigCardImage({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        color: Colors.grey[300],
      ),
      child: image.isEmpty
          ? const Center(
              child: Icon(
                Icons.restaurant,
                size: 80,
                color: Colors.grey,
              ),
            )
          : Image.asset(
              image,
              fit: BoxFit.cover,
            ),
    );
  }
}
