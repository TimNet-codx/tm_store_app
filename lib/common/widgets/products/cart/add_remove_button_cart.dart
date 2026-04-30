import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tm_store_app/common/widgets/icons/t_circular_icon.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/helpers/helper_functions.dart';


class TProductQuantityWithAddRemoveButton extends StatelessWidget {
  const TProductQuantityWithAddRemoveButton({super.key,});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      children: [
        const SizedBox(width: 70,),
        Row(
          children: [
            TCircularIcon(
              icon: Iconsax.minus,
              width: 25,
              height: 25,
              size: TSizes.md,
              color: dark ? TColors.white : TColors.black,
              backgroundColor:  dark ? TColors.darkerGrey : TColors.light,
              ),
              const SizedBox(width:  TSizes.spaceBtwItems,),
              Text('2', style: Theme.of(context).textTheme.titleSmall,),
              const SizedBox(width:  TSizes.spaceBtwItems,),
              TCircularIcon(
              icon: Iconsax.add,
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
