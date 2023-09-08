import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../app_constant.dart';

enum TypeSrcImg { movieDb, external }

// ignore: must_be_immutable
class ImageNetworkWidget extends StatelessWidget {
  ImageNetworkWidget({
    super.key,
    required this.imageSrc,
    this.hieght,
    this.width,
    required this.radius,
    this.onTap,
    this.type = TypeSrcImg.movieDb,
  });
  final TypeSrcImg type;
  final String imageSrc;
  final double? hieght;
  final double? width;
  final double radius;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          // child: CachedNetworkImage(
          //   imageUrl: type == TypeSrcImg.movieDb
          //       ? '${AppConstants.imageUrlW500}${imageSrc}'
          //       : imageSrc,
          //   height: hieght,
          //   width: width,
          //   fit: BoxFit.cover,
          //   placeholder: (context, url) => const CircularProgressIndicator(),
          //   errorWidget: (context, url, error) => const Icon(Icons.error),
          // ),
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
        ),
        //
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }
}
