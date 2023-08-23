import 'package:flutter/material.dart';
import 'package:fluttermovie/presentation/screen/home/favorite_section.dart';
import 'package:fluttermovie/presentation/screen/home/home_section.dart';
import 'package:fluttermovie/presentation/screen/home/map_section.dart';
import 'package:fluttermovie/presentation/screen/home/search_section.dart';
import 'package:fluttermovie/presentation/widget/navigation_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(
      initialPage: 0,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: const [
          HomeSection(),
          SearchSection(),
          FavoriteSection(),
          MapSection()
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black
        ),
        child: Row(
          children: [
            Expanded(
              child: NavigationButton(
                iconAssetPath: 'assets/icons/ic_home.svg',
                isActive: false,
                onPressed: () {
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
                isActive: false,
                onPressed: () {

                },
              ),
            ),
            Expanded(
              child: NavigationButton(
                iconAssetPath: 'assets/icons/ic_favorite.svg',
                isActive: false,
                onPressed: () {

                },
              ),
            ),
            Expanded(
              child: NavigationButton(
                iconAssetPath: 'assets/icons/ic_location.svg',
                isActive: false,
                onPressed: () {
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
  }
}
