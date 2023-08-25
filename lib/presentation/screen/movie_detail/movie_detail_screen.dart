import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttermovie/bloc/movie_cubit.dart';
import 'package:fluttermovie/domain/model/movie.dart';
import 'package:fluttermovie/presentation/widget/base/app_button.dart';
import 'package:fluttermovie/res/colors.dart';

class MovieDetailScreen extends StatefulWidget {
  final int id;

  const MovieDetailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late MovieCubit _movieCubit;

  @override
  void initState() {
    _movieCubit = BlocProvider.of<MovieCubit>(context);

    _movieCubit.getMovieDetail(widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _movieCubit,
      listener: (context, state) {
        if (state is ToggleFavoritesSuccessful) {
          _movieCubit.getMovieDetail(widget.id);

          String message = state.movie != null
              ? "Berhasil menambahkan ke favorit"
              : "Berhasil menghapus dari favorit";
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(message),
          ));
        } else if (state is ToggleFavoritesFailed) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Gagal toggle favorite'),
          ));
        }
      },
      child: BlocBuilder(
        bloc: _movieCubit,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.background,
            body: _movieCubit.getMovieDetailLoading ? Center(
              child: CircularProgressIndicator(
                valueColor:
                AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
              ),
            ) : SingleChildScrollView(
              child: Stack(
                children: [
                  _backdrop(),

                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.45),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _movieCubit.movieDetail!.title,
                          style: const TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.w700
                          ),
                        ),

                        const SizedBox(height: 24),

                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: AppButton(
                                style: AppButtonStyle.primary,
                                text: 'Watch Trailer',
                                iconSvgUri: 'assets/icons/ic_play.svg',
                                onPressed: () {}
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: AppButton(
                                style: AppButtonStyle.secondary,
                                text: _movieCubit.movieDetail!.isFavorite ? 'Remove Fav' : 'Add to Favorite',
                                iconSvgUri: 'assets/icons/ic_plus_primary.svg',
                                onPressed: () {
                                  _movieCubit.toggleFavorite(Movie(
                                    id: widget.id,
                                    title: _movieCubit.movieDetail!.title,
                                    imageUrl: _movieCubit.movieDetail!.imageUrl,
                                    genres: "",
                                    year: "",
                                    isFavorite: _movieCubit.movieDetail!.isFavorite
                                  ));
                                }
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        Text(
                          _movieCubit.movieDetail?.overview ?? '',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.7)
                          ),
                        ),

                        const SizedBox(height: 32),

                        const Text(
                          'Cast',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _backdrop() {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: _movieCubit.movieDetail!.imageUrl,
          height: MediaQuery.of(context).size.height * 0.62,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.63,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: const [0.1, 0.4, 1],
              colors: [
                AppColors.background,
                AppColors.background.withOpacity(0.6),
                Colors.transparent
              ]
            )
          ),
        ),
      ],
    );
  }
}
