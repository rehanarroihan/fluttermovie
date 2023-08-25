import 'package:fluttermovie/domain/model/movie_detail.dart';

class MovieDetailResponse {
  bool? adult;
  String? backdropPath;
  int? budget;
  List<Genres>? genres;
  int? id;
  String? imdbId;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  int? revenue;
  int? runtime;
  String? status;
  String? tagline;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  MovieDetailResponse({
    this.adult,
    this.backdropPath,
    this.budget,
    this.genres,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount
  });

  MovieDetailResponse.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    budget = json['budget'];
    if (json['genres'] != null) {
      genres = <Genres>[];
      json['genres'].forEach((v) {
        genres!.add(Genres.fromJson(v));
      });
    }
    id = json['id'];
    imdbId = json['imdb_id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    revenue = json['revenue'];
    runtime = json['runtime'];
    status = json['status'];
    tagline = json['tagline'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['budget'] = budget;
    if (genres != null) {
      data['genres'] = genres!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    data['imdb_id'] = imdbId;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['release_date'] = releaseDate;
    data['revenue'] = revenue;
    data['runtime'] = runtime;
    data['status'] = status;
    data['tagline'] = tagline;
    data['title'] = title;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }

  MovieDetail toDomain() {
    String year = '0';
    try {
      if (releaseDate != null) {
        year = releaseDate!.split('-').first;
      }
    } catch (e) {
      print(e);
    }

    return MovieDetail(
      id: id ?? 0,
      title: title ?? "",
      imageUrl: "https://image.tmdb.org/t/p/original${posterPath ?? ""}",
      duration: _durationHelper(runtime ?? 0),
      genres: genres!.map((e) => e.name).join(","),
      year: year,
      casts: [],
      overview: overview ?? "",
      isFavorite: false
    );
  }

  String _durationHelper(int runtime) {
    int hours = runtime ~/ 60;
    int minutes = runtime % 60;

    String result = '';

    if (hours > 0) {
      result += '${hours}h';
    }

    if (minutes > 0) {
      if (result.isNotEmpty) {
        result += ' ';
      }
      result += '${minutes}m';
    }

    return result;
  }
}

class Genres {
  int? id;
  String? name;

  Genres({this.id, this.name});

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}