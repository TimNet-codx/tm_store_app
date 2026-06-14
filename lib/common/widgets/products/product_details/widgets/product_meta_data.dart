import 'package:flutter/material.dart';
import 'package:tm_store_app/common/widgets/custom_shape/container/rounded_container.dart';
import 'package:tm_store_app/common/widgets/images/t_circular_image.dart';
import 'package:tm_store_app/common/widgets/texts/product_price_text.dart';
import 'package:tm_store_app/common/widgets/texts/product_title_text.dart';
import 'package:tm_store_app/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:tm_store_app/feastures/shop/models/product_model.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/enums.dart';
import 'package:tm_store_app/utils/constants/image_strings.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/helpers/helper_functions.dart';

class TProdcutMetaData extends StatelessWidget {
  final ProductModel product;
  const TProdcutMetaData({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TRoundedContainer(
              radius: TSizes.sm,
              backgroundColor: TColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(horizontal: TSizes.sm, vertical: TSizes.xs),
              child: Text('25%', style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.black),),
            ),
            const SizedBox(width: TSizes.spaceBtwItems,),
            // Price
            Text('\$250', style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough),),
            const SizedBox(width: TSizes.spaceBtwItems,),
             TProductPriceText(price: product.productPrice.toString()  , isLarge: true,),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5,),
         // Title
          TProductTitleText(title: product.productName),
         const SizedBox(height: TSizes.spaceBtwItems / 1.5,),
        // Stock Status
        Row(
          children: [
         const TProductTitleText(title: 'Status'),
         const SizedBox(width: TSizes.spaceBtwItems),
         Text('In Stock', style: Theme.of(context).textTheme.titleMedium)
          ],
        ),
         const SizedBox(height: TSizes.spaceBtwItems / 1.5,),
         //  Brand
         Row(
          children: [
            TCircularImage(image: TImages.authImage, width: 32, height: 32, overlayColor: dark ? TColors.white : TColors.black,),
            TBrandTitleWithVerifiedIcon(title: product.description, brandTextSize: TextSizes.medium,)
          ],
         )

      ],
    );
  }
}