import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttermovie/res/colors.dart';

enum AppButtonStyle {
  primary,
  secondary,
}

class AppButton extends StatelessWidget {
  final AppButtonStyle style;
  final EdgeInsets? padding;
  final String? iconSvgUri;
  final double? iconSize;
  final String text;
  final double? fontSize;
  final Color? iconColor;
  final FontWeight? fontWeight;
  final VoidCallback onPressed;

  const AppButton({
    Key? key,
    this.style = AppButtonStyle.primary,
    this.padding,
    this.iconSvgUri,
    this.iconSize = 16,
    required this.text,
    this.fontSize,
    this.iconColor,
    this.fontWeight,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var defaultButtonPadding = iconSvgUri != null
        ? const EdgeInsets.symmetric(horizontal: 8, vertical: 12)
        : const EdgeInsets.symmetric(horizontal: 8, vertical: 11);

    switch (style) {
      case AppButtonStyle.primary:
        return TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: Container(
            padding: padding ?? defaultButtonPadding,
            child: _buildButtonChild(
              textColor: Colors.white
            ),
          ),
        );

      case AppButtonStyle.secondary:
        return TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            side: const BorderSide(color: Color.fromRGBO(255, 255, 255, 0.12)),
          ),
          child: Container(
            padding: padding ?? defaultButtonPadding,
            child: _buildButtonChild(
              textColor: Colors.white
            ),
          ),
        );
    }
  }

  Widget _buildButtonChild({
    required Color textColor,
    Color? warnaIcon,
    MainAxisSize mainAxisSize = MainAxisSize.max
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: mainAxisSize,
      children: <Widget>[
        iconSvgUri != null ? Row(
          children: [
            SvgPicture.asset(
              iconSvgUri!,
              color: iconColor ?? warnaIcon,
              height: iconSize,
              width: iconSize,
            ),

            const SizedBox(width: 4)
          ],
        ) :
        const SizedBox(),

        Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize ?? 14,
            fontWeight: fontWeight ?? FontWeight.w400
          ),
        ),
      ],
    );
  }
}
