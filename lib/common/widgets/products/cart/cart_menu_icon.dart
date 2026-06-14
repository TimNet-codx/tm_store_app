import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tm_store_app/provider/cart_provider.dart';
import 'package:tm_store_app/utils/constants/colors.dart';


class TCartCounterIcon extends ConsumerWidget {
  const TCartCounterIcon({
    super.key, required this.onPressed, required this.iconColor
  });

  final Color iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartData = ref.watch(cartProvider);
    return Stack(
      children: [
       IconButton(onPressed: onPressed, icon:  Icon(Iconsax.shopping_bag, color: iconColor)),
       Positioned(
        right: 0,
         child: Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: TColors.black,
            borderRadius: BorderRadius.circular(100)
          ),
          child: Center(
            child: Text(cartData.length.toString(), style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.white, fontSizeFactor: 0.8),),
          ),
         ),
       )
      ],
    );
  }
}
