import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttermovie/bloc/movie_cubit.dart';
import 'package:fluttermovie/presentation/screen/movie_detail/movie_detail_screen.dart';
import 'package:fluttermovie/presentation/widget/modules/movie_thumbnail.dart';
import 'package:fluttermovie/res/colors.dart';

class HomeSection extends StatefulWidget {

  const HomeSection({Key? key}) : super(key: key);

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  late MovieCubit _movieCubit;

  final CarouselController _controller = CarouselController();
  int _carouselCurrentSection = 0;

  @override
  void initState() {
    _movieCubit = BlocProvider.of<MovieCubit>(context);

    if (_movieCubit.movieList.isEmpty) {
      _movieCubit.getMovieList();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                color: AppColors.appBar,
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/images/logo.png'
                      ),
                      IconButton(
                        onPressed: () {

                        },
                        icon: const Icon(
                          Icons.notifications_none,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _carouselSlider(),

                      const SizedBox(height: 28),

                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Popular Movies',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      SizedBox(
                        height: 160,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: _movieCubit.movieList.length,
                          padding: const EdgeInsets.only(left: 20),
                          itemBuilder: (context, index) {
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.28,
                              margin: const EdgeInsets.only(right: 8),
                              child: MovieThumbnail(
                                imageUrl: _movieCubit.movieList[index].imageUrl,
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => MovieDetailScreen(
                                      id: _movieCubit.movieList[index].id,
                                    )
                                  ));
                                },
                              ),
                            );
                          },
                        )
                      ),

                      const SizedBox(height: 32),

                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Coming Soon',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      SizedBox(
                        height: 160,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: _movieCubit.movieList.length,
                          padding: const EdgeInsets.only(left: 20),
                          itemBuilder: (context, index) {
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.28,
                              margin: const EdgeInsets.only(right: 8),
                              child: MovieThumbnail(
                                imageUrl: _movieCubit.movieList[index].imageUrl,
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => MovieDetailScreen(
                                      id: _movieCubit.movieList[index].id,
                                    )
                                  ));
                                },
                              ),
                            );
                          },
                        )
                      ),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _carouselSlider() {
    return Stack(
      children: [
        CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
            height: 280,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() {
                _carouselCurrentSection = index;
              });
            },
          ),
          items: _movieCubit.movieList.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return MovieThumbnail(
                  imageUrl: i.imageUrl,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => MovieDetailScreen(
                        id: i.id,
                      )
                    ));
                  },
                );
              },
            );
          }).toList(),
        ),
        Positioned(
          bottom: 12,
          left: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _movieCubit.movieList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: _carouselCurrentSection == entry.key ? 18 : 12,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    color: Colors.amber.withOpacity(_carouselCurrentSection == entry.key ? 0.9 : 0.4)
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
