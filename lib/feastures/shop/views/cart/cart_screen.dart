import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
import 'package:tm_store_app/feastures/shop/views/cart/widgets/cart_items.dart';
import 'package:tm_store_app/feastures/shop/views/checkout/checkout.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: Text('Cart', style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.white)), showBackArrow: false),
      body: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace), child: TCarItems()),
      bottomNavigationBar: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace), child: ElevatedButton(onPressed: () => Get.to(() => const CheckoutScreen()), child: Text('Checkout \$245'))),
      
    );
  }
}