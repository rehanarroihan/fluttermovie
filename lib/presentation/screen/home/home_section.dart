import 'package:flutter/material.dart';
import 'package:fluttermovie/res/colors.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/logo.png'
                ),
                IconButton(
                  onPressed: () {

                  },
                  icon: const Icon(Icons.notifications_none),
                )
              ],
            ),
          ),
          Text('Popular Movies'),
          Text('Coming Movies'),
        ],
      ),
    );
  }
}
