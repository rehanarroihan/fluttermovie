import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttermovie/bloc/movie_cubit.dart';
import 'package:fluttermovie/presentation/screen/movie_detail/movie_detail_screen.dart';
import 'package:fluttermovie/presentation/widget/base/app_search_bar.dart';
import 'package:fluttermovie/presentation/widget/modules/popular_movie_thumbnail.dart';
import 'package:fluttermovie/res/colors.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({Key? key}) : super(key: key);

  @override
  _SearchSectionState createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
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
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  childAspectRatio: 10/17.5,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  padding: const EdgeInsets.all(8),
                  children: _movieCubit.movieList.map<Widget>((prop) {
                    int index = _movieCubit.movieList.indexWhere((p) => p.id == prop.id);
                    return PopularMovieThumbnail(
                      imageUrl: _movieCubit.movieList[index].imageUrl,
                      title: _movieCubit.movieList[index].title,
                      casts: _movieCubit.movieList[index].casts ?? "",
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => MovieDetailScreen(
                            id: _movieCubit.movieList[index].id,
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
