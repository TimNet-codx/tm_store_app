// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
// import 'package:tm_store_app/common/widgets/custom_shape/curved_edges/curved_edges_widget.dart';
// import 'package:tm_store_app/common/widgets/icons/t_circular_icon.dart';
// import 'package:tm_store_app/common/widgets/images/t_rounded_image.dart';
// import 'package:tm_store_app/feastures/shop/controllers/product_controller.dart';
// import 'package:tm_store_app/feastures/shop/models/product_model.dart';
// import 'package:tm_store_app/utils/constants/colors.dart';
// import 'package:tm_store_app/utils/constants/sizes.dart';
// import 'package:tm_store_app/utils/helpers/helper_functions.dart';

// class TProductImageSlider extends StatelessWidget {
//   final ProductModel product;
//   const TProductImageSlider({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     final dark = THelperFunctions.isDarkMode(context);
//     final ProductController productController = Get.put(ProductController());

//     final isFavourite = productController.favouriteProducts.any((p) => p.id == product.id);

//     return TCurvedEdgeWidget(
//       child: Container(
//         color: dark ? TColors.darkGrey : TColors.light,
//         child: Stack(
//           children: [
//             const SizedBox(height: TSizes.spaceBtwSections),

//             // Main Large Product Image
//             SizedBox(
//               height: 400,
//               child: Padding(
//                 padding: EdgeInsets.all(TSizes.productImageRadius * 2),
//                 //child: Center(child: Image(image: NetworkImage(productController.productDetails[0].images))),
//                 child: Center(
//                   child: Image.network(
//                     //product.images,
//                     product.images.isNotEmpty ? product.images[0] : "",
//                     errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 50),
//                   ),
//                 ),
//               ),
//             ),

//             // Image Slider
//             Positioned(
//               right: 0,
//               bottom: 30,
//               left: TSizes.defaultSpace,
//               child: SizedBox(
//                 height: 70,
//                 child: ListView.separated(
//                   itemCount: product.images.length,
//                   shrinkWrap: true,
//                   scrollDirection: Axis.horizontal,
//                   separatorBuilder: (_, __) => const SizedBox(width: TSizes.spaceBtwItems),
//                   itemBuilder: (_, index) {
//                     final imageUrl = product.images[index];
//                     return TRoundedImage(width: 80, backgroundColor: dark ? TColors.dark : TColors.white, border: Border.all(color: TColors.primary), padding: const EdgeInsets.all(TSizes.sm), imageUrl: imageUrl, isNetworkImage: true);
//                   },
//                 ),
//               ),
//             ),

//             // // AppBar Icons
//             // const TAppBar(
//             //   showBackArrow: true,
//             //   actions: [TCircularIcon(icon: Iconsax.heart5, color: Colors.red)],
//             // ),
//             PreferredSize(
//               //preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.08), // Standard AppBar height
//               preferredSize: const Size.fromHeight(kToolbarHeight),
//               child: Container(
//                 color: TColors.primary, // <-- Your desired background color
//                 child: TAppBar(
//                   showBackArrow: true,
//                   // Pass the color dynamically to the back arrow property if your TAppBar supports it
//                   backArrowColor: dark ? TColors.dark : TColors.light,
//                   title: Text('Product Details', style: Theme.of(context).textTheme.headlineMedium!.apply(color: dark ? TColors.dark : TColors.light)),
//                   actions: [TCircularIcon(icon: isFavourite ? Iconsax.heart5 : Iconsax.heart, color: isFavourite ? Colors.red : Colors.grey, onPressed: () => productController.addAndRemoveFavouriteProduct(product.id))],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
import 'package:tm_store_app/common/widgets/custom_shape/curved_edges/curved_edges_widget.dart';
import 'package:tm_store_app/common/widgets/icons/t_circular_icon.dart';
import 'package:tm_store_app/common/widgets/images/t_rounded_image.dart';
import 'package:tm_store_app/feastures/shop/controllers/product_controller.dart';
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

    // Use Get.find() instead of Get.put() if the controller was already initialized upstream
    final ProductController productController = Get.put(ProductController());

    return TCurvedEdgeWidget(
      child: Container(
        color: dark ? TColors.darkGrey : TColors.light,
        child: Stack(
          children: [
            // Main Large Product Image
            SizedBox(height: 400, child: Padding(padding: EdgeInsets.all(TSizes.productImageRadius * 2), child: Center(child: Image.network(product.images.isNotEmpty ? product.images[0] : "", errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 50))))),

            // Image Slider (Width constrained to fix the previous RenderFlex Overflow)
            Positioned(
              right: 0,
              bottom: 30,
              left: TSizes.defaultSpace,
              child: SizedBox(
                height: 70,
                width: double.infinity,
                child: ListView.separated(
                  itemCount: product.images.length,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (_, __) => const SizedBox(width: TSizes.spaceBtwItems),
                  itemBuilder: (_, index) {
                    final imageUrl = product.images[index];
                    return TRoundedImage(width: 80, backgroundColor: dark ? TColors.dark : TColors.white, border: Border.all(color: TColors.primary), padding: const EdgeInsets.all(TSizes.sm), imageUrl: imageUrl, isNetworkImage: true);
                  },
                ),
              ),
            ),

            // AppBar Icons with Real-time State Updating
            PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Container(
                color: TColors.primary,
                // Fix: Wrapped TAppBar inside Obx() so it rebuilds reactively when productController changes state
                child: Obx(() {
                  // This evaluation now tracks dynamically inside the GetX stream context
                  final isFavourite = productController.favouriteProducts.any((p) => p.id == product.id);

                  return TAppBar(showBackArrow: true, backArrowColor: dark ? TColors.dark : TColors.light, title: Text('Product Details', style: Theme.of(context).textTheme.headlineMedium!.apply(color: dark ? TColors.dark : TColors.light)), actions: [TCircularIcon(icon: isFavourite ? Iconsax.heart5 : Iconsax.heart, color: isFavourite ? Colors.red : Colors.grey, onPressed: () => productController.addAndRemoveFavouriteProduct(product.id))]);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
