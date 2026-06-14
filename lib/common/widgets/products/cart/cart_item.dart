import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tm_store_app/common/widgets/images/t_rounded_image.dart';
import 'package:tm_store_app/common/widgets/texts/product_title_text.dart';
import 'package:tm_store_app/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:tm_store_app/provider/cart_provider.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/image_strings.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/helpers/helper_functions.dart';


class TCartItem extends ConsumerWidget {
  const TCartItem(this.item, {
    super.key,
  });
  final dynamic item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dark = THelperFunctions.isDarkMode(context);
    final cartData = ref.watch(cartProvider);

    return Row(
      children: [
        // Product Image
        //  SizedBox(
        //     width: 60,
        //     height: 60,
        //     child: TRoundedImage(
        //     // imageUrl: cartData.isNotEmpty ? cartData[0]!.images[0] : "",
        //     // imageUrl: (cartData.isNotEmpty && cartData[0]?.images != null && cartData[0]!.images.isNotEmpty) 
        //     // ? cartData[0]!.images[0] 
        //     // : "",
        //    imageUrl: (item?.images != null && item!.images.isNotEmpty) ? item.images[0] : "",
        //     width: 60,
        //     height: 60,
        //     padding: const EdgeInsets.all(TSizes.sm),
        //     backgroundColor: dark ? TColors.darkerGrey : TColors.light,
        //     ),
        //   ),
        SizedBox(
        width: 60,
        height: 60,
        child: (item?.images != null && item!.images.isNotEmpty && item.images[0].isNotEmpty) 
          ? TRoundedImage(
              imageUrl: item.images[0], // Only call this if we have a real string
              width: 60,
              height: 60,
              isNetworkImage: true, 
              applyImageRadius: true,// Set to true if your images are from the internet
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.darkerGrey : TColors.light,
            )
          : const Icon(Icons.image_not_supported, size: 30), // ✅ Show an icon if empty
      ),
          const SizedBox(width: TSizes.spaceBtwItems,),
           // Product Title, price and Size
            Expanded(
              child: Column(
              mainAxisSize: MainAxisSize.min, 
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TBrandTitleWithVerifiedIcon(title: cartData.isNotEmpty ? cartData[0]!.productName : ""),
              //   TBrandTitleWithVerifiedIcon(
              //     title: cartData.isNotEmpty ? (cartData[0]?.productName ?? "") : "",
              //   ),
              //  // Flexible(child: TProductTitleText(title: cartData.isNotEmpty ? cartData[0]!.description : "", maxLines: 1,)),
              //   Flexible(
              //       child: TProductTitleText(
              //         // ✅ Safe check: if item 0 is null or description is null, default to ""
              //         title: cartData.isNotEmpty ? (cartData[0]?.description ?? "") : "", 
              //         maxLines: 1,
              //       ),
              //     ),
              TBrandTitleWithVerifiedIcon(title: item?.productName ?? ""),
              Flexible(
                child: TProductTitleText(
                  title: item?.description ?? "", 
                  maxLines: 1,
                ),
              ),
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