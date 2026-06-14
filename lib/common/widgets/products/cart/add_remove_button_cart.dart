import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tm_store_app/common/widgets/icons/t_circular_icon.dart';
import 'package:tm_store_app/provider/cart_provider.dart';
import 'package:tm_store_app/provider/user_provider.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/helpers/helper_functions.dart';


class TProductQuantityWithAddRemoveButton extends ConsumerWidget {
  const TProductQuantityWithAddRemoveButton(this.item, {super.key,});
  final dynamic item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dark = THelperFunctions.isDarkMode(context);
    final cartData = ref.watch(cartProvider);

    final userState = ref.watch(userProvider);
    final String userId = userState?.id ?? "";
    
    return Row(
      children: [
        const SizedBox(width: 70,),
        Row(
          children: [
            TCircularIcon(
              icon: Iconsax.minus,
              // onPressed: () => ref.read(cartProvider.notifier).decrementProductQuantity(cartData.isNotEmpty ? cartData[0]!.productId : ""),
              // onPressed: () => ref.read(cartProvider.notifier).decrementProductQuantity(
              //   // ✅ Use ?. and ?? instead of !
              //   cartData.isNotEmpty ? (cartData[0]?.productId ?? "") : "",
              // ),
              onPressed: () => ref.read(cartProvider.notifier).decrementProductQuantity(item.productId, userId),
              width: 25,
              height: 25,
              size: TSizes.md,
              color: dark ? TColors.white : TColors.black,
              backgroundColor:  dark ? TColors.darkerGrey : TColors.light,
              ),
              const SizedBox(width:  TSizes.spaceBtwItems,),
              // Text(cartData.isNotEmpty ? cartData[0]!.quantity.toString() : '0', style: Theme.of(context).textTheme.titleSmall,),
              // Text(
              // (cartData.isNotEmpty && cartData[0]?.quantity != null) 
              //     ? cartData[0]!.quantity.toString() 
              //     : '0', 
              // style: Theme.of(context).textTheme.titleSmall,
              // ),
              // Text(
              //   // Use the optional access (?) and provide a fallback (??)
              //   cartData.isNotEmpty ? (cartData[0]?.quantity?.toString() ?? '0') : '0', 
              //   style: Theme.of(context).textTheme.titleSmall,
              // ),
              Text(item.quantity.toString(), style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(width:  TSizes.spaceBtwItems,),
              TCircularIcon(
              icon: Iconsax.add,
             // onPressed: () => ref.read(cartProvider.notifier).incrementProductQuantity(cartData.isNotEmpty ? cartData[0]?.productId ?? "" : ""),
              onPressed: () => ref.read(cartProvider.notifier).incrementProductQuantity(item.productId, userId),
              width: 25,
              height: 25,
              size: TSizes.md,
              color: TColors.white,
              backgroundColor: TColors.primary,
              ),
    
          ],
        )
      ],);
  }
}
