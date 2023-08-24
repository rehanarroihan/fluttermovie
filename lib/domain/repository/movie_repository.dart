import 'package:fluttermovie/data/local/db/dao/favorite_dao.dart';
import 'package:fluttermovie/data/remote/network/movie_service.dart';
import 'package:fluttermovie/data/remote/response/api_return.dart';
import 'package:fluttermovie/data/remote/response/movie_detail_response.dart';
import 'package:fluttermovie/data/remote/response/movie_response.dart';
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
      return (result.data as MovieDetailResponse).toDomain();
    } else {
      return null;
    }
  }
}