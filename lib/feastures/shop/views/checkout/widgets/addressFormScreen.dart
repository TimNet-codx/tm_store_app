// import 'package:flutter/material.dart';
// import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
// import 'package:tm_store_app/utils/constants/colors.dart';
// import 'package:tm_store_app/utils/helpers/helper_functions.dart';

// class AddressFormScreen extends StatelessWidget {
//   final bool isUpdate;
//   const AddressFormScreen({super.key, this.isUpdate = false});

//   @override
//   Widget build(BuildContext context) {
//     final dark = THelperFunctions.isDarkMode(context);
//     return Scaffold(
//       backgroundColor: Colors.white,

//       // appBar: AppBar(
//       //   backgroundColor: Colors.white,
//       //   elevation: 0,
//       //   leading: IconButton(
//       //     icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
//       //     onPressed: () => Navigator.pop(context),
//       //   ),
//       //   title: Text(
//       //     isUpdate ? 'Update Address' : 'Add new Address',
//       //     style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//       //   ),
//       //   centerTitle: true,
//       // ),
//       // appBar: TAppBar(
//       //   showBackArrow: true,
//       //   // title: Text("Checkout", style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.black),),
//       //   title: Text(
//       //     isUpdate ? 'Update Address' : 'Add new Address',
//       //     style: Theme.of(
//       //       context,
//       //     ).textTheme.headlineMedium!.apply(color: TColors.black),
//       //   ),
//       // ),
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(kToolbarHeight),
//         child: Container(
//           color: TColors.primary, // <-- Add your desired background color here
//           child: TAppBar(
//             showBackArrow: true,
//             title: Text(
//               isUpdate ? 'Update Address' : 'Add new Address',
//               style: Theme.of(context).textTheme.headlineMedium!.apply(
//                 color: dark ? TColors.dark : TColors.white,
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     _buildTextField(
//                       Icons.person_outline,
//                       'Name',
//                       isUpdate ? 'Timothy Johnson' : '',
//                     ),
//                     const SizedBox(height: 16),
//                     _buildTextField(
//                       Icons.phone_android_outlined,
//                       'Phone Number',
//                       isUpdate ? '08168172808' : '',
//                     ),
//                     const SizedBox(height: 16),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: _buildTextField(
//                             Icons.home_outlined,
//                             'Street',
//                             isUpdate ? '15 Mark' : '',
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: _buildTextField(
//                             Icons.qr_code_scanner,
//                             'Postal Code',
//                             isUpdate ? '56457' : '',
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: _buildTextField(
//                             Icons.location_city_outlined,
//                             'City',
//                             isUpdate ? 'Ilorin' : '',
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: _buildTextField(
//                             Icons.timeline_outlined,
//                             'State',
//                             isUpdate ? 'Kwara' : '',
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//                     _buildTextField(
//                       Icons.public,
//                       'Country',
//                       isUpdate ? 'Nigeria' : '',
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF2563EB),
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   elevation: 0,
//                 ),
//                 onPressed: () {},
//                 child: const Text(
//                   'Save',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(IconData icon, String label, String initialValue) {
//     return TextFormField(
//       initialValue: initialValue,
//       decoration: InputDecoration(
//         labelText: label,
//         prefixIcon: Icon(icon, color: Colors.grey),
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
import 'package:tm_store_app/feastures/shop/controllers/order_controller.dart';
import 'package:tm_store_app/feastures/shop/models/order_model.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/helpers/helper_functions.dart';

class AddAndUpdateShippingAddressScreen extends StatelessWidget {
  final bool isUpdate;
  final OrderModel? existingOrder;
  final String buyerId;

  const AddAndUpdateShippingAddressScreen({
    super.key,
    this.isUpdate = false,
    this.existingOrder,
    required this.buyerId,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final formKey = GlobalKey<FormState>();

    final controller = Get.put(
      OrderController(isUpdate: isUpdate, buyerId: buyerId),
      tag: 'order_address_form',
    );

    // if (controller.needsPrefillFor(existingOrder)) {
    //   controller.prefillFormFields(existingOrder);
    // }
    // Initial prefill if passing existing order explicitly
    if (existingOrder != null && controller.needsPrefillFor(existingOrder)) {
      controller.prefillFormFields(existingOrder);
    }
    void handleSubmit() {
      if (!formKey.currentState!.validate()) return;

      final updatedOrder = OrderModel(
        id: existingOrder?.id ?? '',
        fullName: controller.fullNameController.text.trim(),
        email: controller.emailController.text.trim(),
        phoneNumber: controller.phoneNumberController.text.trim(),
        street: controller.streetController.text.trim(),
        postalCode: controller.postalCodeController.text.trim(),
        city: controller.cityController.text.trim(),
        state: controller.stateController.text.trim(),
        country: controller.countryController.text.trim(),
        productName: existingOrder?.productName ?? 'Sample Product',
        productPrice: existingOrder?.productPrice ?? 0.0,
        quantity: existingOrder?.quantity ?? 1,
        category: existingOrder?.category ?? 'General',
        buyerId: existingOrder?.buyerId ?? buyerId,
        vendorId: existingOrder?.vendorId ?? '',
        image: existingOrder?.image ?? '',
        processing: existingOrder?.processing ?? true,
        delivered: existingOrder?.delivered ?? false,
      );

      if (isUpdate) {
        controller.updateShippingAddress(order: updatedOrder, context: context);
      } else {
        controller.createShippingAddress(order: updatedOrder, context: context);
      }

      // Return the address data to whoever pushed this screen,
      // so it can be used to update local/cached state immediately.
      Get.back(result: updatedOrder);
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          color: TColors.primary,
          child: TAppBar(
            showBackArrow: true,
            title: Text(
              isUpdate ? 'Update Address' : 'Add new Address',
              style: Theme.of(context).textTheme.headlineMedium!.apply(
                color: dark ? TColors.dark : TColors.light,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                // Name
                TextFormField(
                  controller: controller.fullNameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: 'Name',
                  ),
                  validator:
                      (value) =>
                          (value == null || value.trim().isEmpty)
                              ? 'Name is required'
                              : null,
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                // Email
                TextFormField(
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.sms),
                    labelText: 'Email Address',
                  ),
                  validator:
                      (value) =>
                          (value == null || value.trim().isEmpty)
                              ? 'Email is required'
                              : null,
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                // Phone Number
               TextFormField(
                  controller: controller.phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.mobile),
                    labelText: 'Phone Number',
                  ),
                  validator:
                      (value) =>
                          (value == null || value.trim().isEmpty)
                              ? 'Phone number is required'
                              : null,
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                // Street & Postal Code Row
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.streetController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.building_31),
                          labelText: 'Street',
                        ),
                        validator:
                            (value) =>
                                (value == null || value.trim().isEmpty)
                                    ? 'Required'
                                    : null,
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        controller: controller.postalCodeController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.code),
                          labelText: 'Postal Code',
                        ),
                        validator:
                            (value) =>
                                (value == null || value.trim().isEmpty)
                                    ? 'Required'
                                    : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                // City & State Row
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.cityController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.building),
                          labelText: 'City',
                        ),
                        validator:
                            (value) =>
                                (value == null || value.trim().isEmpty)
                                    ? 'Required'
                                    : null,
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        controller: controller.stateController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.activity),
                          labelText: 'State',
                        ),
                        validator:
                            (value) =>
                                (value == null || value.trim().isEmpty)
                                    ? 'Required'
                                    : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                // Country
                TextFormField(
                  controller: controller.countryController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.global),
                    labelText: 'Country',
                  ),
                  validator:
                      (value) =>
                          (value == null || value.trim().isEmpty)
                              ? 'Country is required'
                              : null,
                ),
                const SizedBox(height: TSizes.defaultSpace),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed:
                          controller.isLoading.value ? null : handleSubmit,
                      child:
                          controller.isLoading.value
                              ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                              : Text(
                                isUpdate ? 'Update Address' : 'Save Address',
                              ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
