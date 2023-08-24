import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MovieThumbnail extends StatelessWidget {
  final String imageUrl;
  final Function? onPressed;

  const MovieThumbnail({
    Key? key,
    required this.imageUrl,
    this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onPressed != null) {
          onPressed!();
        }
      },
      child: CachedNetworkImage(
        width: double.infinity,
        imageUrl: imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
