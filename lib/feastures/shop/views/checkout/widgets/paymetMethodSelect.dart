import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tm_store_app/feastures/shop/controllers/checkout_controller.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/helpers/helper_functions.dart';

class Paymetmethodselect extends StatelessWidget {
  const Paymetmethodselect({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = CheckoutController.instance;
    
       return Container(
      //alignment: Alignment.bottomCenter,
      // ✅ REMOVED: height: 300 (Letting it size itself dynamically)
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: dark ? TColors.dark : TColors.light,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // ✅ This will compress the container to fit perfectly
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: dark ? TColors.white.withOpacity(0.3) : TColors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Select Payment Method',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _paymentOption(context, 'assets/icons/payment_methods/paytm.png', 'Cash on Delivery', controller),
          _paymentOption(context, 'assets/icons/payment_methods/master-card.png', 'Visa/Master Card', controller),
          _paymentOption(context, 'assets/icons/payment_methods/paypal.png', 'Paypal', controller),
        ],
      )
    );
  }

  Widget _paymentOption(BuildContext context, String image, String label, CheckoutController controller) {
    final dark = THelperFunctions.isDarkMode(context);


   return Obx(() {
    final isSelected = controller.selectedPaymentMethod.value.name == label;

        return GestureDetector(
          onTap: () => controller.updatePaymentMethod(label, image),
          child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
          color: dark ? TColors.darkerGrey : TColors.lightGrey,
          borderRadius: BorderRadius.circular(16),
          border: isSelected ? Border.all(color: TColors.primary, width: 2) : null,
                ),
                child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  image,
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 12),
                Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
            // Icon(Iconsax.arrow_right_3, color: dark ? TColors.light : TColors.dark),
            Icon(
                isSelected ? Icons.check_circle : Iconsax.arrow_right_3, 
                color: isSelected ? TColors.primary : (dark ? TColors.light : TColors.dark),
              ),
          ],
                ),
              ),
        );

   });   


  }
}