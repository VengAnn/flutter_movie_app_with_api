import 'package:flutter/material.dart';
import '../app_constant.dart';

enum TypeSrcImg { movieDb, external }

class ImageNetworkWidget extends StatelessWidget {
  const ImageNetworkWidget({
    super.key,
    required this.imageSrc,
    this.hieght,
    this.width,
    required this.radius,
    this.type = TypeSrcImg.movieDb,
  });
  final TypeSrcImg type;
  final String imageSrc;
  final double? hieght;
  final double? width;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(
        type == TypeSrcImg.movieDb
            ? '${AppConstants.imageUrlW500}${imageSrc}'
            : imageSrc,
        height: hieght,
        width: width,
        fit: BoxFit.cover,
        //
        loadingBuilder: (context, child, loadingProgress) {
          return Container(
            height: hieght,
            width: width,
            color: Colors.amber,
            child: child,
          );
        },
        //
        errorBuilder: (_, __, ___) {
          return const SizedBox(
            child: Icon(Icons.broken_image_rounded),
          );
        },
      ),
    );
  }
}
