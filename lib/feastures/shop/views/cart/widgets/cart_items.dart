import 'package:flutter/material.dart';
import 'package:tm_store_app/common/widgets/products/cart/add_remove_button_cart.dart';
import 'package:tm_store_app/common/widgets/products/cart/cart_item.dart';
import 'package:tm_store_app/common/widgets/texts/product_price_text.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';


class TCarItems extends StatelessWidget {
  const TCarItems({super.key, this.showAddRemoveButtons = true});

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 3,
      separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwSections),
      itemBuilder:
          (_, index) => Column(
            children: [
              TCartItem(),
              if (showAddRemoveButtons) const SizedBox(height: TSizes.spaceBtwItems),
              if (showAddRemoveButtons)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Extra Space For Aligning
                        //SizedBox(width: 70,),
                        TProductQuantityWithAddRemoveButton(),
                      ],
                    ),
                    TProductPriceText(price: '256'),
                  ],
                ),
            ],
          ),
    );
  }
}
