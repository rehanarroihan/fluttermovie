import 'package:dio/dio.dart';
import 'package:fluttermovie/app.dart';
import 'package:fluttermovie/data/remote/response/api_return.dart';
import 'package:fluttermovie/data/remote/response/cast_response.dart';
import 'package:fluttermovie/data/remote/response/movie_detail_response.dart';
import 'package:fluttermovie/data/remote/response/movie_response.dart';

class MovieService {
  Dio dio = App().dio;

  final String _apiKey = 'd4bee1442fda04e0b421566f1a54e4ae';

  Future<ApiReturn<List<MovieResponse>>> getMovieList() async {
    try {
      Response response = await dio.get(
        'discover/movie',
        queryParameters: {
          'api_key': _apiKey,
          'language': 'enUS',
          'sort_by': 'popularity.desc',
          'include_adult': false,
          'include_video': false,
          'page': 1,
          'with_genres': true,
        }
      );

      if (response.statusCode == 200) {
        return ApiReturn(
          success: true,
          data: response.data['results'] != null ? List.generate(response.data['results'].length, (index) {
            return MovieResponse.fromJson(response.data['results'][index]);
          }) : null,
        );
      }

      return ApiReturn(success: false, message: 'API Error Ocurred');
    } catch(e) {
      return ApiReturn(
        success: false,
        message: 'Something went wrong'
      );
    }
  }

  Future<ApiReturn<List<MovieResponse>>> getComingSoonMovieList() async {
    try {
      Response response = await dio.get(
          'discover/movie',
          queryParameters: {
            'api_key': _apiKey,
            'language': 'enUS',
            'sort_by': 'popularity.asc',
            'include_adult': false,
            'include_video': false,
            'page': 1,
            'year': DateTime(DateTime.now().year + 1).year,
            'with_genres': true,
          }
      );

      if (response.statusCode == 200) {
        return ApiReturn(
          success: true,
          data: response.data['results'] != null ? List.generate(response.data['results'].length, (index) {
            return MovieResponse.fromJson(response.data['results'][index]);
          }) : null,
        );
      }

      return ApiReturn(success: false, message: 'API Error Ocurred');
    } catch(e) {
      return ApiReturn(
        success: false,
        message: 'Something went wrong'
      );
    }
  }

  Future<ApiReturn<MovieDetailResponse>> getMovieDetail(int id) async {
    try {
      Response response = await dio.get(
        'movie/$id',
        queryParameters: {
          'api_key': _apiKey,
        }
      );

      if (response.statusCode == 200) {
        return ApiReturn(
          success: true,
          data: MovieDetailResponse.fromJson(response.data),
        );
      }

      return ApiReturn(success: false, message: 'API Error Ocurred');
    } catch(e) {
      return ApiReturn(
        success: false,
        message: 'Something went wrong'
      );
    }
  }

  Future<ApiReturn<List<CastResponse>>> getCast(int movieId) async {
    try {
      Response response = await dio.get(
        'movie/$movieId/credits',
        queryParameters: {
          'api_key': _apiKey,
        }
      );

      if (response.statusCode == 200) {
        return ApiReturn(
          success: true,
          data: response.data['cast'] != null ? List.generate(response.data['cast'].length, (index) {
            return CastResponse.fromJson(response.data['cast'][index]);
          }) : null,
        );
      }

      return ApiReturn(success: false, message: 'API Error Ocurred');
    } catch(e) {
      return ApiReturn(
        success: false,
        message: 'Something went wrong'
      );
    }
  }
}