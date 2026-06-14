import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
import 'package:tm_store_app/common/widgets/custom_shape/curved_edges/curved_edges_widget.dart';
import 'package:tm_store_app/common/widgets/icons/t_circular_icon.dart';
import 'package:tm_store_app/common/widgets/images/t_rounded_image.dart';
import 'package:tm_store_app/feastures/shop/models/product_model.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/helpers/helper_functions.dart';

class TProductImageSlider extends StatelessWidget {
  final ProductModel product;
  const TProductImageSlider({super.key, required this.product});


  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    
    return TCurvedEdgeWidget(
      child: Container(
        color: dark ? TColors.darkGrey : TColors.light,
        child: Stack(
          children: [
            // Main Large Product Image
             SizedBox(
              height: 400,
              child: Padding(
              padding:  EdgeInsets.all(TSizes.productImageRadius * 2),
              //child: Center(child: Image(image: NetworkImage(productController.productDetails[0].images))),
              child: Center(
                  child: Image.network(
                    //product.images,
                    product.images.isNotEmpty ? product.images[0] : "",
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, size: 50),
                  ),
                ),
            ),
            ),
    
            // Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: TSizes.defaultSpace,
              child: SizedBox(
                height: 70,
                child: ListView.separated(
                itemCount: product.images.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (_, __) => const SizedBox(width: TSizes.spaceBtwItems,),
                 itemBuilder: (_, index) {
                   final imageUrl = product.images[index];
                  return  TRoundedImage(
                    width: 80,
                    backgroundColor: dark ? TColors.dark : TColors.white,
                    border: Border.all(color: TColors.primary),
                    padding: const EdgeInsets.all(TSizes.sm),
                    imageUrl: imageUrl,
                    isNetworkImage: true,
                    );
                     }
                ),
              ),
            ),
    
            // AppBar Icons
            const TAppBar(
              showBackArrow: true,
              actions: [TCircularIcon(icon: Iconsax.heart5, color: Colors.red)],
            ) 
           
          ],
        ),
      ),
    );
  }
}