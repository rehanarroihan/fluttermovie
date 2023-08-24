import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PopularMovieThumbnail extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String casts;
  final Function? onPressed;

  const PopularMovieThumbnail({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.casts,
    this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        }
      },
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.all(8),
        minimumSize: const Size(0, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 8),

          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400
              ),
            ),
          ),

          Text(
            "Dylan O'Brien, Kaya Scodelario, Will Poulter ",
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 10,
              fontWeight: FontWeight.w400
            ),
          )
        ],
      ),
    );
  }
}