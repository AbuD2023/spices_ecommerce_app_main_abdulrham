import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/app_defaults.dart';

class NetworkImageWithLoader extends StatelessWidget {
  final BoxFit fit;

  /// This widget is used for displaying network image with a placeholder
  const NetworkImageWithLoader(
    this.src, {
    super.key,
    this.fit = BoxFit.cover,
    this.radius = AppDefaults.radius,
    this.borderRadius,
  });

  final String src;
  final double radius;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(20)),
      child: CachedNetworkImage(
        fit: fit,
        imageUrl: src,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: fit,
            ),
          ),
        ),
        errorWidget: (context, url, error) =>
            const Icon(Icons.image_not_supported_outlined),
        // placeholder: (context, url) => const Skeleton(),
        // errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
