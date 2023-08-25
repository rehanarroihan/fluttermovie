import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttermovie/bloc/movie_cubit.dart';
import 'package:fluttermovie/presentation/screen/movie_detail/movie_detail_screen.dart';
import 'package:fluttermovie/presentation/widget/base/app_search_bar.dart';
import 'package:fluttermovie/presentation/widget/modules/popular_movie_thumbnail.dart';
import 'package:fluttermovie/res/colors.dart';

class PopularSection extends StatefulWidget {
  const PopularSection({Key? key}) : super(key: key);

  @override
  _PopularSectionState createState() => _PopularSectionState();
}

class _PopularSectionState extends State<PopularSection> {
  late MovieCubit _movieCubit;

  @override
  void initState() {
    _movieCubit = BlocProvider.of<MovieCubit>(context);

    if (_movieCubit.popularMovieList.isEmpty) {
      _movieCubit.getPopularMovieList();
    }

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
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  childAspectRatio: 10/17.5,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  padding: const EdgeInsets.all(8),
                  children: _movieCubit.popularMovieList.map<Widget>((prop) {
                    int index = _movieCubit.popularMovieList.indexWhere((p) => p.id == prop.id);
                    return PopularMovieThumbnail(
                      imageUrl: _movieCubit.popularMovieList[index].imageUrl,
                      title: _movieCubit.popularMovieList[index].title,
                      casts: _movieCubit.popularMovieList[index].genres ?? "",
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => MovieDetailScreen(
                            id: _movieCubit.popularMovieList[index].id,
                          )
                        ));
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
