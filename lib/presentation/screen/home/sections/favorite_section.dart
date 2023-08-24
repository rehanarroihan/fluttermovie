import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttermovie/bloc/movie_cubit.dart';
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
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _movieCubit.movieList.length,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  itemBuilder: (context, index) {
                    return FavoriteThumbnail(
                      imageUrl: _movieCubit.movieList[index].imageUrl,
                      title: _movieCubit.movieList[index].title,
                      year: _movieCubit.movieList[index].year,
                      genres: _movieCubit.movieList[index].genres,
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}