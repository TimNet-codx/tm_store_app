import 'package:get/get.dart';
import 'package:tm_store_app/feastures/shop/models/paymentMethodModel.dart';
import 'package:tm_store_app/feastures/shop/views/checkout/widgets/addressFormScreen.dart';
import 'package:tm_store_app/feastures/shop/views/checkout/widgets/paystackPaymentScreen.dart';
import 'package:tm_store_app/feastures/shop/views/checkout/widgets/CardPaymentScreen.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  // Observable holding the active selection (Defaulting to Paypal)
  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel(
        name: 'Visa/Master Card',
        image:
            'assets/icons/payment_methods/master-card.png', // Replace with your TImages.paypal path string if needed
      ).obs;

  // Method to update selection and shut the bottom sheet
  void updatePaymentMethod(String name, String image) {
    selectedPaymentMethod.value = PaymentMethodModel(name: name, image: image);
    Get.back(); // Automatically closes the bottom sheet modal!
  }

  /// 🚀 ROUTING LOGIC BASED ON PAYMENT METHOD
  void processCheckout(double totalAmount) {
    final method = selectedPaymentMethod.value.name;

    switch (method) {
      case 'Cash on Delivery':
        // Direct user to input/select delivery location
        Get.to(() => const AddAndUpdateShippingAddressScreen(isUpdate: false, buyerId: 'buyer_id'),);
        break;

      case 'Visa/Master Card':
      case 'Verve Card':
        // Direct user to Card Information Screen
        Get.to(() => CardPaymentScreen(totalAmount: totalAmount));
        break;

      case 'Paystack':
        // Direct user to Paystack Gateway Screen
        Get.to(() => PaystackPaymentScreen(totalAmount: totalAmount));
        break;

      default:
        // Default Fallback
        break;
      // Get.to(() => SuccessScreen(
      //       image: TImages.successfulPaymentIcon,
      //       title: 'Payment Success',
      //       subTitle: 'Your item will be shipped soon!',
      //       onPressed: () => Get.offAll(() => MainScreen()),
      //     ));
    }
  }
}
