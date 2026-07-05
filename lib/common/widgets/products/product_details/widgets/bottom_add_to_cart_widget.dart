import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tm_store_app/common/widgets/icons/t_circular_icon.dart';
import 'package:tm_store_app/feastures/shop/models/product_model.dart';
import 'package:tm_store_app/provider/cart_provider.dart';
import 'package:tm_store_app/provider/user_provider.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/helpers/helper_functions.dart';
import 'package:tm_store_app/utils/popups/loaders.dart';

// class TBottomAddToCart extends ConsumerWidget {
//   final ProductModel product;
//   const TBottomAddToCart(this.product, {super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final dark = THelperFunctions.isDarkMode(context);
//    // 1. Watch the cart state
//     final cartData = ref.watch(cartProvider);

//     final userState = ref.watch(userProvider);
//     final String userId = userState?.id ?? '';

//     // 2. Check if THIS product is in the cart map
//     final cartItem = cartData[product.id];

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
//       decoration: BoxDecoration(
//         color: dark ? TColors.darkerGrey : TColors.light,
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(TSizes.cardRadiusLg),
//           topRight: Radius.circular(TSizes.cardRadiusLg),
//         )
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               TCircularIcon(
//                 icon: Iconsax.minus,
//                 // 3. Only allow decrement if the item is in the cart
//                 onPressed: cartItem == null
//                     ? null
//                     : () => ref.read(cartProvider.notifier).decrementProductQuantity(product.id, userId),
//                 backgroundColor: TColors.darkGrey,
//                 width: 40,
//                 height: 40,
//                 color: TColors.white,
//               ),
//               const SizedBox(width: TSizes.spaceBtwItems),

//               // 4. FIX: Use 'cartItem?.quantity' or default to 0
//               Text(
//                 (cartItem?.quantity ?? 0).toString(),
//                 style: Theme.of(context).textTheme.titleSmall,
//               ),

//               const SizedBox(width: TSizes.spaceBtwItems),
//               TCircularIcon(
//                 icon: Iconsax.add,
//                 // 5. Increment quantity
//                 onPressed: cartItem == null
//                     ? null
//                     : () => ref.read(cartProvider.notifier).incrementProductQuantity(product.id, userId),
//                 backgroundColor: TColors.black,
//                 width: 40,
//                 height: 40,
//                 color: TColors.white,
//               ),
//             ],
//           ),

//           ElevatedButton(
//             onPressed: () {
//               ref.read(cartProvider.notifier).addProductToCart(
//                 productName: product.productName,
//                 productPrice: product.productPrice,
//                 category: product.category,
//                 images: product.images,
//                 vendorId: product.vendorId,
//                 productQuantity: product.productQuantity, // Fix: Use productQuantity here
//                 quantity: 1,
//                 id: product.id,
//                 description: product.description,
//                 fullName: product.fullName, userId: userId,
//               );
//               TLoaders.successSnackBar(title: 'Added', message: '${product.productName} added to cart');
//             },
//             style: ElevatedButton.styleFrom(
//               padding: const EdgeInsets.all(TSizes.md),
//               backgroundColor: TColors.black,
//               side: const BorderSide(color: TColors.black),
//             ),
//             child: const Text('Add to Cart', style: TextStyle(color: TColors.white)),
//           )
//         ],
//       ),

//     );
//   }
// }

// class TBottomAddToCart extends ConsumerWidget {
//   final ProductModel product;
//   const TBottomAddToCart(this.product, {super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final dark = THelperFunctions.isDarkMode(context);
//     final cartData = ref.watch(cartProvider);

//     // Watch the active session profile
//     // final userState = ref.watch(userProvider);
//     // final String userId = userState?.id ?? '';
//     // print("DEBUG: Active User Object is: $userState | Extracted ID is: '${userState?.id}'");
//     final String userId = Get.find<UserController>().user.value?.id ?? '';

//     final cartItem = cartData[product.id];

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
//       decoration: BoxDecoration(
//         color: dark ? TColors.darkerGrey : TColors.light,
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(TSizes.cardRadiusLg),
//           topRight: Radius.circular(TSizes.cardRadiusLg),
//         )
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               TCircularIcon(
//                 icon: Iconsax.minus,
//                 // Block interaction if item isn't in cart or session isn't loaded
//                 onPressed: (cartItem == null || userId.isEmpty)
//                     ? null
//                     : () => ref.read(cartProvider.notifier).decrementProductQuantity(product.id, userId),
//                 backgroundColor: TColors.darkGrey,
//                 width: 40,
//                 height: 40,
//                 color: TColors.white,
//               ),
//               const SizedBox(width: TSizes.spaceBtwItems),

//               Text(
//                 (cartItem?.quantity ?? 0).toString(),
//                 style: Theme.of(context).textTheme.titleSmall,
//               ),

//               const SizedBox(width: TSizes.spaceBtwItems),
//               TCircularIcon(
//                 icon: Iconsax.add,
//                 // Block interaction if item isn't in cart or session isn't loaded
//                 onPressed: (cartItem == null || userId.isEmpty)
//                     ? null
//                     : () => ref.read(cartProvider.notifier).incrementProductQuantity(product.id, userId),
//                 backgroundColor: TColors.black,
//                 width: 40,
//                 height: 40,
//                 color: TColors.white,
//               ),
//             ],
//           ),

//           ElevatedButton(
//             onPressed: userId.isEmpty
//               ? () {
//                   TLoaders.errorSnackBar(
//                     title: 'Login Required',
//                     message: 'Please authenticate into your account to manage your shopping cart.'
//                   );
//                 }
//               : () {
//                   ref.read(cartProvider.notifier).addProductToCart(
//                     productName: product.productName,
//                     productPrice: product.productPrice,
//                     category: product.category,
//                     images: product.images,
//                     vendorId: product.vendorId,
//                     productQuantity: product.productQuantity,
//                     quantity: 1,
//                     id: product.id,
//                     description: product.description,
//                     fullName: product.fullName,
//                     userId: userId,
//                   );
//                   TLoaders.successSnackBar(title: 'Added', message: '${product.productName} added to cart');
//                 },
//             style: ElevatedButton.styleFrom(
//               padding: const EdgeInsets.all(TSizes.md),
//               backgroundColor: TColors.black,
//               side: const BorderSide(color: TColors.black),
//             ),
//             child: const Text('Add to Cart', style: TextStyle(color: TColors.white)),
//           )
//         ],
//       ),
//     );
//   }
// }

// class TBottomAddToCart extends ConsumerWidget {
//   final ProductModel product;
//   const TBottomAddToCart(this.product, {super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final dark = THelperFunctions.isDarkMode(context);

//     // 1. Watch the synchronized cart state tree
//     final cartData = ref.watch(cartProvider);

//     // 2. ✅ FIX: Watch your now operational Riverpod userProvider state!
//     final userState = ref.watch(userProvider);
//     final String userId = userState?.id ?? '';

//     // Debug helper to print status to your logs
//     print("🔍 UI Detection -> Active User ID: '$userId' | Cart Items Count: ${cartData.length}");

//     final cartItem = cartData[product.id];

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
//       decoration: BoxDecoration(
//         color: dark ? TColors.darkerGrey : TColors.light,
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(TSizes.cardRadiusLg),
//           topRight: Radius.circular(TSizes.cardRadiusLg),
//         )
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               TCircularIcon(
//                 icon: Iconsax.minus,
//                 // Disable minus button if item is missing or user is not found
//                 onPressed: (cartItem == null || userId.isEmpty)
//                     ? null
//                     : () => ref.read(cartProvider.notifier).decrementProductQuantity(product.id, product.userId),
//                 backgroundColor: TColors.darkGrey,
//                 width: 40,
//                 height: 40,
//                 color: TColors.white,
//               ),
//               const SizedBox(width: TSizes.spaceBtwItems),

//               Text(
//                 (cartItem?.quantity ?? 0).toString(),
//                 style: Theme.of(context).textTheme.titleSmall,
//               ),

//               const SizedBox(width: TSizes.spaceBtwItems),
//               TCircularIcon(
//                 icon: Iconsax.add,
//                 // Disable plus button if item is missing or user is not found
//                 onPressed: (cartItem == null || userId.isEmpty)
//                     ? null
//                     : () => ref.read(cartProvider.notifier).incrementProductQuantity(product.id, product.userId),
//                 backgroundColor: TColors.black,
//                 width: 40,
//                 height: 40,
//                 color: TColors.white,
//               ),
//             ],
//           ),

//           ElevatedButton(
//             onPressed: userId.isEmpty
//               ? () {
//                   TLoaders.errorSnackBar(
//                     title: 'Login Required',
//                     message: 'Please authenticate into your account to manage your shopping cart.'
//                   );
//                 }
//               : () {
//                   ref.read(cartProvider.notifier).addProductToCart(
//                     productName: product.productName,
//                     productPrice: product.productPrice,
//                     category: product.category,
//                     images: product.images,
//                     vendorId: product.vendorId,
//                     productQuantity: product.productQuantity,
//                     quantity: 1,
//                     id: product.id,
//                     description: product.description,
//                     fullName: product.fullName,
//                     userId: product.userId,
//                   );
//                   TLoaders.successSnackBar(title: 'Added', message: '${product.productName} added to cart');
//                 },
//             style: ElevatedButton.styleFrom(
//               padding: const EdgeInsets.all(TSizes.md),
//               backgroundColor: TColors.black,
//               side: const BorderSide(color: TColors.black),
//             ),
//             child: const Text('Add to Cart', style: TextStyle(color: TColors.white)),
//           )
//         ],
//       ),
//     );
//   }
// }

class TBottomAddToCart extends ConsumerWidget {
  final ProductModel product;
  const TBottomAddToCart(this.product, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dark = THelperFunctions.isDarkMode(context);

    // 1. Watch the synchronized cart state tree
    final cartData = ref.watch(cartProvider);

    // 2. Watch your logged-in user state session
    final userState = ref.watch(userProvider);
    final String userId = userState?.id ?? "";

    // Debug helper to verify context values live
    print("🔍 UI Detection -> Logged-In Customer ID: '$userId' | Product Uploaded By Vendor ID: '${product.userId}'");

    final cartItem = cartData[product.id];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
      decoration: BoxDecoration(color: dark ? TColors.darkerGrey : TColors.light, borderRadius: const BorderRadius.only(topLeft: Radius.circular(TSizes.cardRadiusLg), topRight: Radius.circular(TSizes.cardRadiusLg))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              TCircularIcon(
                icon: Iconsax.minus,
                // Disable minus button if item is missing or user session is empty
                //onPressed: () => ref.read(cartProvider.notifier).decrementProductQuantity(item.productId, userId),
                onPressed: () => ref.read(cartProvider.notifier).decrementProductQuantity(product.id, userId), // ✅ FIX: Use 'userId'
                backgroundColor: TColors.darkGrey,
                width: 40,
                height: 40,
                color: TColors.white,
              ),
              const SizedBox(width: TSizes.spaceBtwItems),

              Text((cartItem?.quantity ?? 0).toString(), style: Theme.of(context).textTheme.titleSmall),

              const SizedBox(width: TSizes.spaceBtwItems),
              TCircularIcon(
                icon: Iconsax.add,
                // Disable plus button if item is missing or user session is empty
                onPressed: () => ref.read(cartProvider.notifier).incrementProductQuantity(product.id, userId), // ✅ FIX: Use 'userId'
                backgroundColor: TColors.black,
                width: 40,
                height: 40,
                color: TColors.white,
              ),
            ],
          ),

          ElevatedButton(
            onPressed: () {
              ref
                  .read(cartProvider.notifier)
                  .addProductToCart(
                    productName: product.productName,
                    productPrice: product.productPrice,
                    category: product.category,
                    images: product.images,
                    vendorId: product.vendorId,
                    productQuantity: product.productQuantity,
                    quantity: 1,
                    id: product.id,
                    description: product.description,
                    fullName: product.fullName,
                    userId: userId, // ✅ FIX: Pass the authenticated customer 'userId' here!
                  );
              TLoaders.successSnackBar(title: 'Added', message: '${product.productName} added to cart');
            },
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(TSizes.md), backgroundColor: TColors.black, side: const BorderSide(color: TColors.black)),
            child: const Text('Add to Cart', style: TextStyle(color: TColors.white)),
          ),
        ],
      ),
    );
  }
}
