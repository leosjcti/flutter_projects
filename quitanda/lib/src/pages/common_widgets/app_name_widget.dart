import 'package:flutter/material.dart';
import '../../config/custom_colors.dart';

class AppNameWidget extends StatelessWidget {
  const AppNameWidget({
    super.key, this.greenTitleColor, this.textSize = 30,
  });

  final Color? greenTitleColor;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: textSize,
        ),
        children: [
          TextSpan(
            text: 'Quit',
            style: TextStyle(
              color: greenTitleColor ?? CustomColors.customSwatchColor,
            ),
          ),
          TextSpan(
            text: 'anda',
            style: TextStyle(
              color: CustomColors.customContrastColor,
            ),
          ),
        ],
      ),
    );
  }
}