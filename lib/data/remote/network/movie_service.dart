import 'package:dio/dio.dart';
import 'package:fluttermovie/app.dart';
import 'package:fluttermovie/data/remote/response/api_return.dart';
import 'package:fluttermovie/data/remote/response/movie_detail_response.dart';
import 'package:fluttermovie/data/remote/response/movie_response.dart';

class MovieService {
  Dio dio = App().dio;

  Future<ApiReturn<List<MovieResponse>>> getMovieList() async {
    try {
      Response response = await dio.get(
        'discover/movie?api_key=d4bee1442fda04e0b421566f1a54e4ae&language=enUS&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&year=2024&with_genres=true'
      );

      if (response.statusCode == 200) {
        return ApiReturn(
          success: true,
          data: response.data['results'] != null ? List.generate(response.data['results'].length, (index) {
            return MovieResponse.fromJson(response.data['results'][index]);
          }) : null,
        );
      }

      return ApiReturn(success: false, message: response.data['message']);
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
        'movie/$id?api_key=d4bee1442fda04e0b421566f1a54e4ae'
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
}