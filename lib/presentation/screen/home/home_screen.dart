import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttermovie/bloc/movie_cubit.dart';
import 'package:fluttermovie/presentation/screen/home/sections/favorite_section.dart';
import 'package:fluttermovie/presentation/screen/home/sections/home_section.dart';
import 'package:fluttermovie/presentation/screen/home/sections/map_section.dart';
import 'package:fluttermovie/presentation/screen/home/sections/search_section.dart';
import 'package:fluttermovie/presentation/widget/base/navigation_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MovieCubit _movieCubit;

  late PageController _controller;

  @override
  void initState() {
    _movieCubit = BlocProvider.of<MovieCubit>(context);

    _controller = PageController(
      initialPage: 0,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _movieCubit,
      builder: (context, state) {
        return Scaffold(
          body: PageView(
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              HomeSection(),
              SearchSection(),
              FavoriteSection(),
              MapSection()
            ],
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              color: Colors.black
            ),
            child: Row(
              children: [
                Expanded(
                  child: NavigationButton(
                    iconAssetPath: 'assets/icons/ic_home.svg',
                    isActive: _movieCubit.activePage == 0,
                    onPressed: () {
                      _movieCubit.changeActivePage(0);
                      _controller.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease
                      );
                    },
                  ),
                ),
                Expanded(
                  child: NavigationButton(
                    iconAssetPath: 'assets/icons/ic_award.svg',
                    isActive: _movieCubit.activePage == 1,
                    onPressed: () {
                      _movieCubit.changeActivePage(1);
                      _controller.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease
                      );
                    },
                  ),
                ),
                Expanded(
                  child: NavigationButton(
                    iconAssetPath: 'assets/icons/ic_favorite.svg',
                    isActive: _movieCubit.activePage == 2,
                    onPressed: () {
                      _movieCubit.changeActivePage(2);
                      _controller.animateToPage(
                        2,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease
                      );
                    },
                  ),
                ),
                Expanded(
                  child: NavigationButton(
                    iconAssetPath: 'assets/icons/ic_location.svg',
                    isActive: _movieCubit.activePage == 3,
                    onPressed: () {
                      _movieCubit.changeActivePage(3);
                      _controller.animateToPage(
                        3,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
