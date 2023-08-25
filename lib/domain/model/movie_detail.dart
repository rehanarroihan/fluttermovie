import 'package:fluttermovie/domain/model/cast.dart';

class MovieDetail {
  int id;
  String title;
  String imageUrl;
  String duration;
  String genres;
  String year;
  String overview;
  bool isFavorite;
  List<Cast> casts;

  MovieDetail({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.genres,
    required this.year,
    required this.overview,
    required this.isFavorite,
    required this.casts,
  });
}