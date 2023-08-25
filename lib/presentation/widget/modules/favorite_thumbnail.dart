import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FavoriteThumbnail extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String year;
  final String genres;
  final Function? onPressed;
  final Function? onToggle;

  const FavoriteThumbnail({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.year,
    required this.genres,
    this.onPressed,
    this.onToggle,
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
        padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
        minimumSize: const Size(0, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width * 0.48,
                  height: MediaQuery.of(context).size.height * 0.12,
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 4),
                        child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        year,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.7)
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        genres,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.7)
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () {
              if (onToggle != null) {
                onToggle!();
              }
            },
            style: TextButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: const EdgeInsets.all(4),
              minimumSize: const Size(0, 0),
            ),
            icon: const Icon(
              Icons.favorite,
              size: 18,
            ),
          )
        ],
      ),
    );
  }
}
