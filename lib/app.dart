import 'package:dio/dio.dart';
import 'package:fluttermovie/data/local/db/flutter_movie_database.dart';

class App {
  static App? _instance;
  final String? apiBaseURL;
  late FlutterMovieDatabase dbConnection;
  late Dio dio;

  App.configure({
    this.apiBaseURL,
  }) {
    _instance = this;
  }

  factory App() {
    if (_instance == null) {
      throw UnimplementedError("App must be configured first.");
    }

    return _instance!;
  }

  Future<void> init() async {
    dio = Dio(BaseOptions(
      baseUrl: apiBaseURL!,
      connectTimeout: const Duration(milliseconds: 10000),
      receiveTimeout: const Duration(milliseconds: 50000),
      responseType: ResponseType.json
    ));

    dbConnection = FlutterMovieDatabase.instance;
  }
}