import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tm_store_app/common/widgets/custom_shape/container/rounded_container.dart';
import 'package:tm_store_app/common/widgets/icons/t_circular_icon.dart';
import 'package:tm_store_app/common/widgets/images/t_rounded_image.dart';
import 'package:tm_store_app/common/widgets/products/product_details/product_detail.dart';
import 'package:tm_store_app/common/widgets/texts/product_price_text.dart';
import 'package:tm_store_app/common/widgets/texts/product_title_text.dart';
import 'package:tm_store_app/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:tm_store_app/feastures/shop/controllers/product_controller.dart';
import 'package:tm_store_app/feastures/shop/models/product_model.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/helpers/helper_functions.dart';
import 'package:tm_store_app/utils/styles/shadows.dart';


class TProductCardVertical extends StatelessWidget {
  final ProductModel product; 
  const TProductCardVertical({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final ProductController productController = Get.put(ProductController());
    //final controller = Get.find<ProductController>();

    return GestureDetector(
       onTap: () => Get.to(() => ProductDetailScreen(product: product)),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.white,
        ),
        child: Column(   
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Product Image with Sale Tag and Favorite Icon
            TRoundedContainer(
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  children: [
                    // Product Image
                    TRoundedImage(
                     // imageUrl: product.images,
                      imageUrl: product.images.isNotEmpty ? product.images[0] : "",
                      isNetworkImage: true,
                      applyImageRadius: true,
                    ),

                    // Sale Tag
                    Positioned(
                      top: 12,
                      child: TRoundedContainer(
                        radius: TSizes.sm,
                        backgroundColor: TColors.secondary.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: TSizes.sm, vertical: TSizes.xs),
                        child: Text(
                          '25%',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .apply(color: TColors.black),
                        ),
                      ),
                    ),

        
                    Obx(() {
                        // DEBUG: This should print every time you click the heart 
                        print("UI Rebuilding. Fav List Size: ${productController.favouriteProducts.length}");

                        // Use a string comparison directly
                       final isFavourite = productController.favouriteProducts.any((p) => p.id == product.id);

                        return Positioned(
                          top: 0,
                          right: 0,
                          child: TCircularIcon(
                            icon: isFavourite ? Iconsax.heart5 : Iconsax.heart,
                            color: isFavourite ? Colors.red : Colors.grey,
                            onPressed: () => productController.addAndRemoveFavouriteProduct(product.id),
                          ),
                        );
                      })
                            ],
                ),
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwItems / 2),

            /// Product Details
            Padding(
              padding: const EdgeInsets.only(left: TSizes.sm, right: TSizes.sm, bottom: TSizes.sm),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title
               TProductTitleText(
                  title: product.description, // Fallback text
                  smallSize: true, 
                ), 
                   const SizedBox(height: TSizes.spaceBtwItems / 2),

                  /// Brand & Verified
                  TBrandTitleWithVerifiedIcon(title: product.category,),

                 // const SizedBox(height: TSizes.spaceBtwItems / 2),
                 
                ],
              ),
            ),
           Spacer(),
                  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               /// Price & Add Button
                  Padding(
                    padding: const EdgeInsets.only(left: TSizes.sm),
                    child: TProductPriceText(price: product?.productPrice.toString() ?? "0.00"),
                  ),
                    // Add to cart Button
                     Container(
                      decoration: const BoxDecoration(
                        color: TColors.dark,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(TSizes.cardRadiusMd),
                          bottomRight:
                              Radius.circular(TSizes.productImageRadius),
                        ),
                      ),
                      child: const SizedBox(
                        width: TSizes.iconLg * 1.2,
                        height: TSizes.iconLg * 1.2,
                        child: Center(
                          child: Icon(
                            Iconsax.add,
                            color: TColors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ) 
          ],
        ),
      ),
    );
  }
}



