import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tm_store_app/common/widgets/custom_shape/container/rounded_container.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/helpers/helper_functions.dart';


class TSingleAddress extends StatelessWidget {
  const TSingleAddress({super.key, required this.selectedAddress});

  final bool selectedAddress;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TRoundedContainer(
        width: double.infinity,
        showBorder: true,
        padding: const EdgeInsets.all(TSizes.md),
        // ignore: deprecated_member_use
        backgroundColor: selectedAddress ? TColors.primary.withOpacity(0.3) : Colors.transparent,
        borderColor: selectedAddress ? Colors.transparent
         : dark ? TColors.darkerGrey : TColors.grey,
         margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
         child: Stack(
          children: [
            Positioned(
              right: 5,
              top: 0,
              child: Icon( 
                selectedAddress ? Iconsax.tick_circle5 : null, 
                color: selectedAddress 
                  ? dark 
                    ? TColors.light
                    : TColors.dark
                    : null),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Emmanuel Mark',
                   maxLines: 2,
                   overflow: TextOverflow.ellipsis,
                   style: Theme.of(context).textTheme.titleLarge,
                   ),
                   const SizedBox(height: TSizes.sm / 2,),
                   const Text('+234 8031234567', maxLines: 1, overflow: TextOverflow.ellipsis,),
                   const SizedBox(height: TSizes.sm / 2,),
                   const Text('82 Timmy Coves, South Liana, Maine, 3782, USA', softWrap: true,)
              ],
            )
          ],
         ),
        );
  }
}