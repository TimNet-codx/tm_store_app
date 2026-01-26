// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:tm_store_app/common/widgets/texts/t_brand_title_text.dart';
// import 'package:tm_store_app/utils/constants/sizes.dart';


// class TBrandTitleWithVerifiedIcon extends StatelessWidget {
//   const TBrandTitleWithVerifiedIcon({
//     super.key, required this.title, this.maxLine = 1, this.textAlign = TextAlign.center, this.brandTextSize = TextSizes.small, this.textColor, this.iconColor = TColors.primary,
//   });

//   final String title;
//   final int maxLine;
//   final Color? textColor, iconColor;
//   final TextAlign? textAlign;
//   final TextSizes brandTextSize;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//        Flexible(
//         child: TBrandTitleText(
//           title: title,
//           color: textColor,
//           maxLine: maxLine,
//           textAlign: textAlign,
//           brandTextSize: brandTextSize,
//           ),
//           ),
//         const SizedBox(width: TSizes.xs),
//          Icon(
//           Iconsax.verify5,
//           color: iconColor,
//           size: TSizes.iconXs,
//         )
//       ],
//     );
//   }
// }