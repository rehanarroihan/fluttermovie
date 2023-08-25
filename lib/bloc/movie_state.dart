part of 'movie_cubit.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {}

class ChangeActivePageInit extends MovieState {}

class ChangeActivePageFinished extends MovieState {}

class GetMovieListInit extends MovieState {}

class GetMovieListSuccessful extends MovieState {}

class GetMovieListFailed extends MovieState {}

class GetMovieDetailInit extends MovieState {}

class GetMovieDetailSuccessful extends MovieState {}

class GetMovieDetailFailed extends MovieState {}

class GetFavoritesInit extends MovieState {}

class GetFavoritesSuccessful extends MovieState {}

class GetFavoritesFailed extends MovieState {}

class ToggleFavoritesInit extends MovieState {}

class ToggleFavoritesSuccessful extends MovieState {
  final Movie? movie;

  const ToggleFavoritesSuccessful(this.movie);
}

class ToggleFavoritesFailed extends MovieState {}

class GetPopularMovieListInit extends MovieState {}

class GetPopularMovieListSuccessful extends MovieState {}

class GetPopularMovieListFailed extends MovieState {}