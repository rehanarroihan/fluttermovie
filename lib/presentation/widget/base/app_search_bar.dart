import 'package:flutter/material.dart';
import 'package:fluttermovie/res/colors.dart';

class AppSearchBar extends StatelessWidget {
  final String? hint;

  const AppSearchBar({
    Key? key,
    this.hint
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 16,
          color: Colors.white.withOpacity(0.7)
        ),
        suffixIcon: Icon(
          Icons.search,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
