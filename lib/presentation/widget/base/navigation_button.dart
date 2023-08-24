import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttermovie/res/colors.dart';

class NavigationButton extends StatelessWidget {
  final String iconAssetPath;
  final bool isActive;
  final Function onPressed;

  const NavigationButton({
    Key? key,
    required this.iconAssetPath,
    required this.isActive,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.zero,
        minimumSize: const Size(0, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        foregroundColor: Colors.white
      ),
      onPressed: () {
        onPressed();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        child: SvgPicture.asset(
          iconAssetPath,
          height: 28,
          width: 28,
          color: isActive ? AppColors.primaryColor : Colors.white,
        ),
      ),
    );
  }
}
