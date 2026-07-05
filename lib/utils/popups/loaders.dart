import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tm_store_app/common/widgets/loaders/animation_loader.dart';

import '../constants/colors.dart';
import '../helpers/helper_functions.dart';

class TLoaders {
  static hideSnackBar() => ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();

  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!, // Use Get.overlayContext for overlay dialogs
      barrierDismissible: false, // The dialog can't be dismissed by tapping outside it
      builder:
          (_) => PopScope(
            canPop: false, // Disable popping with the back button
            child: Container(
              color: THelperFunctions.isDarkMode(Get.context!) ? TColors.darkContainer : TColors.white,
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 250), // Adjust the spacing as needed
                  TAnimationLoaderWidget(text: text, animation: animation),
                ],
              ),
            ),
          ),
    );
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop(); // Close the dialog using the Navigator
  }

  static customToast({required message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(elevation: 0, duration: const Duration(seconds: 3), backgroundColor: Colors.transparent, content: Container(padding: const EdgeInsets.all(12.0), margin: const EdgeInsets.symmetric(horizontal: 30), decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: THelperFunctions.isDarkMode(Get.context!) ? TColors.darkerGrey.withValues(alpha: 0.9) : TColors.grey.withValues(alpha: 0.9)), child: Center(child: Text(message, style: Theme.of(Get.context!).textTheme.bodySmall)))));
  }

  static successSnackBar({required title, message = '', duration = 3}) {
    Get.snackbar(title, message, isDismissible: true, shouldIconPulse: true, colorText: Colors.white, backgroundColor: TColors.dashboardAppbarBackground, snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: duration), margin: const EdgeInsets.all(10), icon: const Icon(Iconsax.check, color: TColors.white));
  }

  static warningSnackBar({required title, message = ''}) {
    Get.snackbar(title, message, isDismissible: true, shouldIconPulse: true, colorText: TColors.white, backgroundColor: Colors.black54, snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 3), margin: const EdgeInsets.all(20), icon: const Icon(Iconsax.warning_2, color: TColors.white));
  }

  static errorSnackBar({required title, message = ''}) {
    Get.snackbar(title, message, isDismissible: true, shouldIconPulse: true, colorText: TColors.white, backgroundColor: Colors.red.shade600, snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 3), margin: const EdgeInsets.all(20), icon: const Icon(Iconsax.warning_2, color: TColors.white));
  }
}
