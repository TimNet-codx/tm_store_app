import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tm_store_app/provider/cart_provider.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';


class TBillingAmountSection extends ConsumerWidget {
  const TBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
final totalAmount = ref.read(cartProvider.notifier).calculateTotaLAmount();

    return Column(
      children: [
        // Subtotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium,),
            Text('\$$totalAmount', style: Theme.of(context).textTheme.bodyMedium,)
          ],),
          const SizedBox(height: TSizes.spaceBtwItems /2,),

          //Shipping Fee
           Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shipping Fee', style: Theme.of(context).textTheme.bodyMedium,),
            Text('\$5.0', style: Theme.of(context).textTheme.labelLarge,)
          ],),
          const SizedBox(height: TSizes.spaceBtwItems /2,),

          // Tax Fee
             Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tax Fee', style: Theme.of(context).textTheme.bodyMedium,),
            Text('\$3.0', style: Theme.of(context).textTheme.labelLarge,)
          ],),
          const SizedBox(height: TSizes.spaceBtwItems /2,),
           
           // Order Total
            Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order Total', style: Theme.of(context).textTheme.bodyMedium,),
            Text('\$$totalAmount', style: Theme.of(context).textTheme.titleMedium,)
          ],),
          const SizedBox(height: TSizes.spaceBtwItems /2,),
      ],
    );
  }
}