import 'package:flutter/material.dart';

import '../app_constant.dart';

class ImageNetworkWidget extends StatelessWidget {
  const ImageNetworkWidget(
      {super.key,
      required this.imageSrc,
      this.hieght,
      this.width,
      required this.radius});
  final String imageSrc;
  final double? hieght;
  final double? width;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(
        // ignore: unnecessary_brace_in_string_interps
        '${AppConstants.imageUrlW500}${imageSrc}',
        height: hieght,
        width: width,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return const SizedBox(
            child: Icon(Icons.broken_image_rounded),
          );
        },
      ),
    );
  }
}
