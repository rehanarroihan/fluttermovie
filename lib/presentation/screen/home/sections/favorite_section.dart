import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttermovie/bloc/movie_cubit.dart';
import 'package:fluttermovie/domain/model/movie.dart';
import 'package:fluttermovie/presentation/screen/movie_detail/movie_detail_screen.dart';
import 'package:fluttermovie/presentation/widget/base/app_search_bar.dart';
import 'package:fluttermovie/presentation/widget/modules/favorite_thumbnail.dart';
import 'package:fluttermovie/res/colors.dart';

class FavoriteSection extends StatefulWidget {
  const FavoriteSection({Key? key}) : super(key: key);

  @override
  State<FavoriteSection> createState() => _FavoriteSectionState();
}

class _FavoriteSectionState extends State<FavoriteSection> {
  late MovieCubit _movieCubit;

  @override
  void initState() {
    _movieCubit = BlocProvider.of<MovieCubit>(context);

    _movieCubit.getFavoriteList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _movieCubit,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8
                ),
                color: AppColors.appBar,
                child: const SafeArea(
                  child: AppSearchBar(
                    hint: 'Search',
                  ),
                ),
              ),

              Expanded(
                child: _body(),
              )
            ],
          )
        );
      },
    );
  }

  Widget _body() {
    if (_movieCubit.getFavoriteListLoading) {
      return Center(
        child: CircularProgressIndicator(
          valueColor:
          AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
        ),
      );
    }

    if (_movieCubit.favoriteList.isEmpty) {
      return const Center(
        child: Text(
          'Belum ada daftar favorite',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: _movieCubit.favoriteList.length,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemBuilder: (context, index) {
        return FavoriteThumbnail(
          imageUrl: _movieCubit.favoriteList[index].imageUrl,
          title: _movieCubit.favoriteList[index].title,
          year: _movieCubit.favoriteList[index].year,
          genres: _movieCubit.favoriteList[index].genres,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => MovieDetailScreen(
                id: _movieCubit.favoriteList[index].id,
              )
            ));
          },
          onToggle: () {
            _movieCubit.toggleFavorite(Movie(
              id: _movieCubit.favoriteList[index].id,
              title: _movieCubit.favoriteList[index].title,
              imageUrl: _movieCubit.favoriteList[index].imageUrl,
              genres: "",
              year: "",
              isFavorite: _movieCubit.favoriteList[index].isFavorite
            ));
          },
        );
      },
    );
  }
}