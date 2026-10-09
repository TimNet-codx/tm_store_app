import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
import 'package:tm_store_app/feastures/shop/views/checkout/widgets/CardOtpScreen.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/helpers/helper_functions.dart';

class CardPinScreen extends StatelessWidget {
  const CardPinScreen({super.key, required this.totalAmount});

  final double totalAmount;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      // appBar: AppBar(title: const Text('Enter Card PIN')),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          color: TColors.primary, // <-- Add your desired background color here
          child: TAppBar(
            showBackArrow: true,
            title: Text(
              "Enter Card PIN",
              style: Theme.of(context).textTheme.headlineMedium!.apply(
                color: dark ? TColors.dark : TColors.white,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter 4-Digit Card PIN',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Text(
              'Please enter your 4-digit ATM PIN to authorize the transaction.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            TextFormField(
              keyboardType: TextInputType.number,
              obscureText: true,
              maxLength: 4,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                letterSpacing: 16,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                hintText: '••••',
                counterText: '',
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                // 🔄 Navigate to OTP Screen
                onPressed:
                    () => Get.to(() => CardOtpScreen(totalAmount: totalAmount)),
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
