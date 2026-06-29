import 'package:get/get.dart';
import 'package:tm_store_app/feastures/shop/models/paymentMethodModel.dart';


class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  // Observable holding the active selection (Defaulting to Paypal)
  final Rx<PaymentMethodModel> selectedPaymentMethod = PaymentMethodModel(
    name: 'Paypal', 
    image: 'assets/icons/payment_methods/paypal.png', // Replace with your TImages.paypal path string if needed
  ).obs;

  // Method to update selection and shut the bottom sheet
  void updatePaymentMethod(String name, String image) {
    selectedPaymentMethod.value = PaymentMethodModel(name: name, image: image);
    Get.back(); // Automatically closes the bottom sheet modal!
  }
}