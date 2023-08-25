import 'package:fluttermovie/data/local/db/dao/favorite_dao.dart';
import 'package:fluttermovie/data/local/db/entities/favorite_entity.dart';
import 'package:fluttermovie/data/remote/network/movie_service.dart';
import 'package:fluttermovie/data/remote/response/api_return.dart';
import 'package:fluttermovie/data/remote/response/cast_response.dart';
import 'package:fluttermovie/data/remote/response/movie_detail_response.dart';
import 'package:fluttermovie/data/remote/response/movie_response.dart';
import 'package:fluttermovie/domain/model/cast.dart';
import 'package:fluttermovie/domain/model/movie.dart';
import 'package:fluttermovie/domain/model/movie_detail.dart';

class MovieRepository {
  final MovieService _movieService = MovieService();
  final FavoriteDao _favoriteDao = FavoriteDao();

  Future<List<Movie>> getMovieList() async {
    ApiReturn<List<MovieResponse>> result = await _movieService.getMovieList();
    if (result.success) {
      List<Movie> res = [];
      result.data?.forEach((MovieResponse e) {
        res.add(e.toDomain());
      });

      return res;
    } else {
      return [];
    }
  }

  Future<MovieDetail?> getMovieDetail(int id) async {
    ApiReturn<MovieDetailResponse> result = await _movieService.getMovieDetail(id);
    if (result.success) {
      var res = (result.data as MovieDetailResponse).toDomain();

      ApiReturn<List<CastResponse>> castResult = await _movieService.getCast(id);
      List<Cast> casTemp = [];
      castResult.data?.forEach((CastResponse e) {
        casTemp.add(e.toDomain());
      });

      res.casts = casTemp;
      return res;
    } else {
      return null;
    }
  }

  Future<List<Movie>> getFavorites() async {
    List result = await _favoriteDao.query();
    return result.cast<FavoriteEntity>().map((FavoriteEntity e) => e.toDomain()).toList();
  }

  Future<Movie?> toggleFavorite(Movie movie) async {
    try {
      FavoriteEntity entity = FavoriteEntity(
        id: movie.id,
        imageUrl: movie.imageUrl,
        title: movie.title,
        genres: movie.genres,
        year: movie.year
      );

      if (movie.isFavorite) {
        await _favoriteDao.rawQuery("DELETE FROM favorite WHERE movie_id = ${movie.id}");
      } else {
        await _favoriteDao.insert(entity);
      }

      List result = await _favoriteDao.query(where: 'movie_id = ?', whereArgs: [entity.id]);
      return result.cast<FavoriteEntity>().map((FavoriteEntity e) => e.toDomain()).toList().firstOrNull;
    } catch (e) {
      rethrow;
    }
  }
}