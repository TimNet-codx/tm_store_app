import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tm_store_app/common/widgets/products/cart/add_remove_button_cart.dart';
import 'package:tm_store_app/common/widgets/products/cart/cart_item.dart';
import 'package:tm_store_app/common/widgets/texts/product_price_text.dart';
import 'package:tm_store_app/provider/cart_provider.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';

class TCarItems extends ConsumerWidget {
  const TCarItems({super.key, this.showAddRemoveButtons = true});

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Define the map by watching the provider
    final cartMap = ref.watch(cartProvider);
    // 2. Convert that map into a list so the ListView can use it
    final cartList = cartMap.values.toList();

    return ListView.separated(
      shrinkWrap: true,
      // 3. Use the list length
      itemCount: cartList.length,
      separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwSections),
      itemBuilder: (_, index) {
        // 4. Get the specific item for this index
        final item = cartList[index];
        //if (item == null) return const SizedBox();
        return Column(
          children: [
            TCartItem(item),
            if (showAddRemoveButtons) const SizedBox(height: TSizes.spaceBtwItems),
            if (showAddRemoveButtons)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // Extra Space For Aligning
                      //SizedBox(width: 70,),
                      TProductQuantityWithAddRemoveButton(item),
                    ],
                  ),
                  // TProductPriceText(price: '256'),
                  //   TProductPriceText(
                  //   price: cartData.isNotEmpty
                  //       ? (cartData[0]?.productPrice?.toString() ?? "0")
                  //       : "0",
                  //   isLarge: true,
                  // )
                  TProductPriceText(price: ((item.productPrice ?? 0) * (item.quantity ?? 1)).toString(), isLarge: true),
                ],
              ),
          ],
        );
      },
    );
  }
}
