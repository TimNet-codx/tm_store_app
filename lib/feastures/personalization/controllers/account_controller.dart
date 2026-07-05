// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tm_store_app/feastures/authentication/controllers/user_controller.dart';
// import 'package:tm_store_app/feastures/authentication/models/user.dart';
//  // adjust path

// class AddressFormController extends GetxController {
//   final bool isUpdate;
//   final userController = Get.find<UserController>();

//   AddressFormController({this.isUpdate = false});

//   final formKey = GlobalKey<FormState>();

//   late final TextEditingController nameController;
//   late final TextEditingController phoneController;
//   late final TextEditingController streetController;
//   late final TextEditingController postalCodeController;
//   late final TextEditingController cityController;
//   late final TextEditingController stateController;
//   late final TextEditingController countryController;

//   @override
//   void onInit() {
//     super.onInit();
//     final existingUser = userController.user.value;

//     nameController = TextEditingController(text: isUpdate ? existingUser?.fullName : '');
//     phoneController = TextEditingController(text: isUpdate ? existingUser?.phoneNumber : '');
//     streetController = TextEditingController(text: isUpdate ? existingUser?.street : '');
//     postalCodeController = TextEditingController(text: isUpdate ? existingUser?.postalCode : '');
//     cityController = TextEditingController(text: isUpdate ? existingUser?.city : '');
//     stateController = TextEditingController(text: isUpdate ? existingUser?.state : '');
//     countryController = TextEditingController(text: isUpdate ? existingUser?.country : '');
//   }

//   @override
//   void onClose() {
//     nameController.dispose();
//     phoneController.dispose();
//     streetController.dispose();
//     postalCodeController.dispose();
//     cityController.dispose();
//     stateController.dispose();
//     countryController.dispose();
//     super.onClose();
//   }

//   Future<void> handleSubmit() async {
//     if (!formKey.currentState!.validate()) return;

//     final updatedUser = UserModel(
//       fullName: nameController.text.trim(),
//       email: userController.user.value!.email,
//       phoneNumber: phoneController.text.trim(),
//       street: streetController.text.trim(),
//       postalCode: postalCodeController.text.trim(),
//       city: cityController.text.trim(),
//       state: stateController.text.trim(),
//       country: countryController.text.trim(), id: '', password: '', token: '',
//     );

//     await userController.addOrUpdateUserDetails(updatedUser);

//     Get.back();
//     Get.snackbar('Success', isUpdate ? 'Address updated!' : 'Address added!');
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_store_app/feastures/authentication/controllers/user_controller.dart';
import 'package:tm_store_app/feastures/authentication/models/user.dart';

class AddressFormController extends GetxController {
  final bool isUpdate;
  final userController = Get.find<UserController>();

  AddressFormController({this.isUpdate = false});

  final formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController streetController;
  late final TextEditingController postalCodeController;
  late final TextEditingController cityController;
  late final TextEditingController stateController;
  late final TextEditingController countryController;

  @override
  void onInit() {
    super.onInit();
    final existingUser = userController.user.value;

    nameController = TextEditingController(text: isUpdate ? existingUser?.fullName : '');
    phoneController = TextEditingController(text: isUpdate ? existingUser?.phoneNumber : '');
    streetController = TextEditingController(text: isUpdate ? existingUser?.street : '');
    postalCodeController = TextEditingController(text: isUpdate ? existingUser?.postalCode : '');
    cityController = TextEditingController(text: isUpdate ? existingUser?.city : '');
    stateController = TextEditingController(text: isUpdate ? existingUser?.state : '');
    countryController = TextEditingController(text: isUpdate ? existingUser?.country : '');
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    streetController.dispose();
    postalCodeController.dispose();
    cityController.dispose();
    stateController.dispose();
    countryController.dispose();
    super.onClose();
  }

  Future<void> handleSubmit() async {
    if (!formKey.currentState!.validate()) return;

    final updatedUser = UserModel(fullName: nameController.text.trim(), email: userController.user.value!.email, phoneNumber: phoneController.text.trim(), street: streetController.text.trim(), postalCode: postalCodeController.text.trim(), city: cityController.text.trim(), state: stateController.text.trim(), country: countryController.text.trim(), id: '', password: '', token: '');

    await userController.addOrUpdateUserDetails(updatedUser);

    Get.back();
    Get.snackbar('Success', isUpdate ? 'Address updated!' : 'Address added!');
  }
}
