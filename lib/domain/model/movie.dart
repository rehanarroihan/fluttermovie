class Movie {
  int id;
  String title;
  String imageUrl;
  String genres;
  String? casts;
  String year;
  bool isFavorite;

  Movie({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.genres,
    this.casts,
    required this.year,
    required this.isFavorite
  });
}