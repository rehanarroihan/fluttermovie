import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttermovie/domain/model/movie.dart';
import 'package:fluttermovie/domain/model/movie_detail.dart';
import 'package:fluttermovie/domain/repository/movie_repository.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(MovieInitial());

  final MovieRepository _repository = MovieRepository();

  int activePage = 0;

  List<Movie> movieList = [];
  bool getMovieListLoading = false;

  MovieDetail? movieDetail;
  bool getMovieDetailLoading = false;

  List<Movie> favoriteList = [];
  bool getFavoriteListLoading = false;

  void changeActivePage(int page) {
    emit(ChangeActivePageInit());

    activePage = page;

    emit(ChangeActivePageFinished());
  }

  void getMovieList() async {
    getMovieListLoading = true;
    emit(GetMovieListInit());

    movieList.clear();
    var result = await _repository.getMovieList();
    movieList.addAll(result);

    getMovieListLoading = false;
    emit(GetMovieListSuccessful());
  }

  void getMovieDetail(int id) async {
    movieDetail = null;
    getMovieDetailLoading = true;
    emit(GetMovieDetailInit());

    MovieDetail? result = await _repository.getMovieDetail(id);
    if (result != null) {
      movieDetail = result;
      List<Movie> favoriteList = await _repository.getFavorites();
      movieDetail!.isFavorite = favoriteList.where((mv) => mv.id == result.id).isNotEmpty;
    }

    getMovieDetailLoading = false;
    emit(GetMovieDetailFailed());
  }

  void toggleFavorite(Movie movie) async {
    emit(ToggleFavoritesInit());

    try {
      Movie? result = await _repository.toggleFavorite(movie);
      emit(ToggleFavoritesSuccessful(result));

      getFavoriteList();
    } catch (e) {
      emit(ToggleFavoritesFailed());
    }
  }

  void getFavoriteList() async {
    favoriteList.clear();
    getMovieListLoading = true;
    emit(GetFavoritesInit());

    var result = await _repository.getFavorites();
    favoriteList.addAll(result);

    getMovieListLoading = false;
    emit(GetFavoritesSuccessful());
  }
}