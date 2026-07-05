import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
import 'package:tm_store_app/feastures/shop/views/cart/widgets/cart_items.dart';
import 'package:tm_store_app/feastures/shop/views/checkout/checkout.dart';
import 'package:tm_store_app/provider/cart_provider.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/helpers/helper_functions.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dark = THelperFunctions.isDarkMode(context);

    //  // 1. Watch the provider (This is a Map<String, CartModel>)
    //   final cartMap = ref.watch(cartProvider);

    //   // 2. Calculate the total price safely
    //   // We use .values to get the items, then fold them into a single sum
    //   final double totalPrice = cartMap.values.fold(
    //     0.0,
    //     (sum, item) => sum + (item.productPrice * item.quantity),
    //   );
    // 1. Watch the state so the widget rebuilds when items are added/removed
    final cartData = ref.watch(cartProvider);

    // 2. Access the notifier to call your calculation method
    final totalAmount = ref.read(cartProvider.notifier).calculateTotaLAmount();

    return Scaffold(
      //appBar: TAppBar(title: Text('Cart', style: Theme.of(context).textTheme.headlineMedium!.apply(color: dark ? Colors.white : Colors.black)), showBackArrow: true),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight), // Standard AppBar height
        child: Container(
          color: TColors.primary, // <-- Your desired background color
          child: TAppBar(showBackArrow: true, title: Text('Cart', style: Theme.of(context).textTheme.headlineMedium!.apply(color: dark ? TColors.dark : TColors.light))),
        ),
      ),
      body: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace), child: TCarItems()),
      bottomNavigationBar: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace), child: ElevatedButton(onPressed: () => Get.to(() => const CheckoutScreen()), child: Text('Checkout \$$totalAmount'))),
    );
  }
}
