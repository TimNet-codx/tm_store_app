import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
import 'package:tm_store_app/common/widgets/success_screen/success_screen.dart';
import 'package:tm_store_app/main_screen.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/image_strings.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/helpers/helper_functions.dart';

class CardOtpScreen extends StatelessWidget {
  const CardOtpScreen({super.key, required this.totalAmount});

  final double totalAmount;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      // appBar: AppBar(title: const Text('OTP Verification')),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          color: TColors.primary, // <-- Add your desired background color here
          child: TAppBar(
            showBackArrow: true,
            title: Text(
              "OTP Verification",
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
            Text('Enter OTP', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Text(
              'An OTP has been sent to your registered phone number/email.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            TextFormField(
              keyboardType: TextInputType.number,
              maxLength: 6,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                letterSpacing: 12,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                hintText: '••••••',
                counterText: '',
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                // 🏁 Final Success Navigation
                onPressed:
                    () => Get.offAll(
                      () => SuccessScreen(
                        image: TImages.successfulPaymentIcon,
                        title: 'Payment Success',
                        subTitle: 'Your item will be shipped soon!',
                        onPressed: () => Get.offAll(() => MainScreen()),
                      ),
                    ),
                child: Text('Authorize \$$totalAmount'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
