// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
// import 'package:tm_store_app/common/widgets/success_screen/success_screen.dart';
// import 'package:tm_store_app/main_screen.dart';
// import 'package:tm_store_app/utils/constants/colors.dart';
// import 'package:tm_store_app/utils/constants/image_strings.dart';
// import 'package:tm_store_app/utils/constants/sizes.dart';
// import 'package:tm_store_app/utils/helpers/helper_functions.dart';

// class PaystackPaymentScreen extends StatelessWidget {
//   const PaystackPaymentScreen({super.key, required this.totalAmount});

//   final double totalAmount;

//   @override
//   Widget build(BuildContext context) {
//     final dark = THelperFunctions.isDarkMode(context);
//     return Scaffold(
//       // appBar: AppBar(title: const Text('Paystack Gateway')),
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(kToolbarHeight),
//         child: Container(
//           color: TColors.primary, // <-- Add your desired background color here
//           child: TAppBar(
//             showBackArrow: true,
//             title: Text(
//               "Paystack Gateway",
//               style: Theme.of(context).textTheme.headlineMedium!.apply(
//                 color: dark ? TColors.dark : TColors.white,
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(TSizes.defaultSpace),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.payment, size: 80, color: Colors.blue),
//             const SizedBox(height: TSizes.spaceBtwItems),
//             Text(
//               'Total Amount: \$$totalAmount',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//             const SizedBox(height: TSizes.spaceBtwSections),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed:
//                     () => Get.offAll(
//                       () => SuccessScreen(
//                         image: TImages.successfulPaymentIcon,
//                         title: 'Payment Success',
//                         subTitle: 'Your item will be shipped soon!',
//                         onPressed: () => Get.offAll(() => MainScreen()),
//                       ),
//                     ),
//                 child: const Text('Proceed with Paystack'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
// import 'package:tm_store_app/feastures/shop/controllers/paystack_controller.dart';
// import 'package:tm_store_app/utils/constants/colors.dart';
// import 'package:tm_store_app/utils/constants/sizes.dart';
// import 'package:tm_store_app/utils/helpers/helper_functions.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class PaystackPaymentScreen extends StatelessWidget {
//   const PaystackPaymentScreen({
//     super.key,
//     required this.totalAmount,
//     this.email = 'user@example.com',
//   });

//   final double totalAmount;
//   final String email;

//   @override
//   Widget build(BuildContext context) {
//     final dark = THelperFunctions.isDarkMode(context);

//     // Inject the controller and trigger initial setup
//     final PaystackController controller = Get.put(PaystackController());

//     // Kick off payment flow without lifecycle dependency
//     controller.startPaymentFlow(email: email, amount: totalAmount);

//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(kToolbarHeight),
//         child: Container(
//           color: TColors.primary, // <-- Add your desired background color here
//           child: TAppBar(
//             showBackArrow: true,
//             title: Text(
//               "Paystack Payment",
//               style: Theme.of(context).textTheme.headlineMedium!.apply(
//                 color: dark ? TColors.dark : TColors.white,
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value || !controller.isWebViewReady.value) {
//           return Padding(
//             padding: const EdgeInsets.all(TSizes.defaultSpace),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const CircularProgressIndicator(),
//                 const SizedBox(height: TSizes.spaceBtwSections),
//                 Text(
//                   'Initializing Paystack Gateway...',
//                   style: Theme.of(context).textTheme.bodyMedium,
//                 ),
//               ],
//             ),
//           );
//         }

//         return WebViewWidget(controller: controller.webViewController);
//       }),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
import 'package:tm_store_app/feastures/shop/controllers/paystack_controller.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/helpers/helper_functions.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaystackPaymentScreen extends StatelessWidget {
  const PaystackPaymentScreen({
    super.key,
    required this.totalAmount,
    this.email = 'user@example.com',
  });

  final double totalAmount;
  final String email;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    // Inject unique controller with constructor dependencies
    final PaystackController controller = Get.put(PaystackController());

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        // Handle WebView internal navigation before popping screen
        if (controller.isWebViewReady.value &&
            await controller.webViewController.canGoBack()) {
          await controller.webViewController.goBack();
        } else {
          _showCancelConfirmationDialog(context);
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            color: TColors.primary,
            child: TAppBar(
              showBackArrow: true,
              leadingOnPressed: () async {
                if (controller.isWebViewReady.value &&
                    await controller.webViewController.canGoBack()) {
                  await controller.webViewController.goBack();
                } else {
                  _showCancelConfirmationDialog(context);
                }
              },
              title: Text(
                "Paystack Payment",
                style: Theme.of(context).textTheme.headlineMedium!.apply(
                  color: dark ? TColors.dark : TColors.white,
                ),
              ),
            ),
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value || !controller.isWebViewReady.value) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: TSizes.spaceBtwSections),
                    Text(
                      'Initializing Paystack Gateway...',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            );
          }

          return WebViewWidget(controller: controller.webViewController);
        }),
      ),
    );
  }

  void _showCancelConfirmationDialog(BuildContext context) {
    Get.defaultDialog(
      title: 'Cancel Payment',
      middleText: 'Are you sure you want to cancel this payment transaction?',
      textConfirm: 'Yes, Cancel',
      textCancel: 'Continue Payment',
      confirmTextColor: Colors.white,
      buttonColor: TColors.primary,
      onConfirm: () {
        Get.back(); // Close dialog
        Get.back(); // Exit Paystack screen
      },
    );
  }
}
