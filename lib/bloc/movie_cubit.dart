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

  List<Movie> highlighMovieList = [];
  List<Movie> movieList = [];
  List<Movie> comingSoonList = [];
  bool getMovieListLoading = false;

  List<Movie> popularMovieList = [];
  List<Movie> backupPopularMovieList = []; // for local search function
  bool getPopularMovieListLoading = false;

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

    highlighMovieList.clear();
    movieList.clear();
    List<Movie> result = await _repository.getMovieList();
    highlighMovieList = result.sublist(0, 3);
    movieList = result.sublist(3, 13);

    comingSoonList.clear();
    List<Movie> resultComingSoonMovie  = await _repository.getComingSoonMovieList();
    comingSoonList = resultComingSoonMovie.sublist(0, 10);

    getMovieListLoading = false;
    emit(GetMovieListSuccessful());
  }

  void getPopularMovieList({ String? searchQuery }) async {
    getPopularMovieListLoading = true;
    emit(GetPopularMovieListInit());

    if (searchQuery != null && searchQuery.isNotEmpty) {
      List<Movie> searchResult = backupPopularMovieList.where((movie) {
        return movie.title.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
      popularMovieList.clear();
      popularMovieList.addAll(searchResult);
    } else {
      popularMovieList.clear();
      backupPopularMovieList.clear();
      List<Movie> result = await _repository.getMovieList();
      popularMovieList.addAll(result.reversed);
      backupPopularMovieList.addAll(result.reversed);
    }

    getPopularMovieListLoading = false;
    emit(GetPopularMovieListSuccessful());
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

  void getFavoriteList({ String? searchQuery }) async {
    favoriteList.clear();
    getMovieListLoading = true;
    emit(GetFavoritesInit());

    List<Movie> result = searchQuery == null || searchQuery.isEmpty
      ? await _repository.getFavorites()
      : await _repository.searchFavorite(searchQuery);
    favoriteList.addAll(result);

    getMovieListLoading = false;
    emit(GetFavoritesSuccessful());
  }
}