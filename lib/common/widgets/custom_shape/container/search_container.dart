import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/device/device_utility.dart';
import 'package:tm_store_app/utils/helpers/helper_functions.dart';

class TSearchContainer extends StatelessWidget {
  const TSearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.iconC = Iconsax.camera,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
    this.padding =
        const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
  });

  final String text;
  final IconData? icon;
  final IconData? iconC;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
          width: TDeviceUtils.getScreenWidth(context),
          //padding: const EdgeInsets.all(TSizes.md),
          decoration: BoxDecoration(
            color: showBackground
                ? dark
                    ? TColors.dark
                    : TColors.light
                : Colors.transparent,
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
            border: showBorder ? Border.all(color: TColors.grey) : null,
          ),
          child: TextField(
            readOnly: false,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: TColors.darkerGrey),
              hintText: text,
              hintStyle: Theme.of(context).textTheme.bodySmall,
              suffixIcon: Icon(iconC, color: TColors.darkerGrey),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
