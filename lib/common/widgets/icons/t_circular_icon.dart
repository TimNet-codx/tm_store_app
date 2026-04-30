import 'package:flutter/material.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/helpers/helper_functions.dart';


class TCircularIcon extends StatelessWidget {
  const TCircularIcon({
    super.key,
   this.width, this.height, this.size = TSizes.lg, required this.icon, this.color, this.onPressed, this.backgroundColor,
  });

  final double? width, height, size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        // color: dark ? TColors.black.withOpacity(0.9) : TColors.white.withOpacity(0.9)
       color:  backgroundColor != null ? backgroundColor! :THelperFunctions.isDarkMode(context) ? TColors.black.withOpacity(0.9) : TColors.white.withOpacity(0.9),
      ),
      child: IconButton(onPressed: onPressed, icon: Icon(icon, color: color, size: size,)),
    );
  }
}