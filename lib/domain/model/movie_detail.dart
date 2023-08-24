class MovieDetail {
  int id;
  String title;
  String imageUrl;
  List<String> genres;
  String casts;
  String overview;
  bool isFavorite;

  MovieDetail({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.genres,
    required this.casts,
    required this.overview,
    required this.isFavorite
  });
}