import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
import 'package:tm_store_app/feastures/shop/views/checkout/widgets/CardPinScreen.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/helpers/helper_functions.dart';

class CardPaymentScreen extends StatelessWidget {
  const CardPaymentScreen({super.key, required this.totalAmount});

  final double totalAmount;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      // appBar: AppBar(title: const Text('Card Payment')),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          color: TColors.primary, // <-- Add your desired background color here
          child: TAppBar(
            showBackArrow: true,
            title: Text(
              "Card Payment",
              style: Theme.of(context).textTheme.headlineMedium!.apply(
                color: dark ? TColors.dark : TColors.white,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Card Number',
                prefixIcon: Icon(Icons.credit_card),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Expiry Date (MM/YY)',
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                ),
                const SizedBox(width: TSizes.spaceBtwInputFields),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'CVV'),
                    keyboardType: TextInputType.number,
                    obscureText: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                // 🔄 Navigate to Card PIN Screen
                onPressed:
                    () => Get.to(() => CardPinScreen(totalAmount: totalAmount)),
                child: Text('Proceed \$$totalAmount'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
