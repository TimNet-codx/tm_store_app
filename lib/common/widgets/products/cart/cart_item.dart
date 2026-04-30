import 'package:flutter/material.dart';
import 'package:tm_store_app/common/widgets/images/t_rounded_image.dart';
import 'package:tm_store_app/common/widgets/texts/product_title_text.dart';
import 'package:tm_store_app/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/image_strings.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/helpers/helper_functions.dart';


class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      children: [
        // Product Image
         SizedBox(
            width: 60,
            height: 60,
            child: TRoundedImage(
            imageUrl: TImages.authImage,
            width: 60,
            height: 60,
            padding: const EdgeInsets.all(TSizes.sm),
            backgroundColor: dark ? TColors.darkerGrey : TColors.light,
            ),
          ),
          const SizedBox(width: TSizes.spaceBtwItems,),
           // Product Title, price and Size
            Expanded(
              child: Column(
               mainAxisSize: MainAxisSize.min, 
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TBrandTitleWithVerifiedIcon(title: 'Nike'),
                const Flexible(child: TProductTitleText(title: 'Black Sports shoes ', maxLines: 1,)),
                // Attributes
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'Color: ', style: Theme.of(context).textTheme.bodySmall),
                      TextSpan(text: 'Green ', style: Theme.of(context).textTheme.bodyLarge,),
                      TextSpan(text: 'Size: ', style: Theme.of(context).textTheme.bodySmall,),
                      TextSpan(text: 'UK 40', style: Theme.of(context).textTheme.bodyLarge,),
                    ]
                  )
                )
              ],
                                     ),
            )
        
      ],
    );
  }
}