// // import 'package:flutter/material.dart';
// // import 'package:iconsax/iconsax.dart';
// // import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
// // import 'package:tm_store_app/utils/constants/colors.dart';
// // import 'package:tm_store_app/utils/constants/sizes.dart';

// // class AddNewAddressScreen extends StatelessWidget {
// //   final bool isUpdate;
// //   final String initialValue;
// //    const AddNewAddressScreen({super.key, this.isUpdate = false, this.initialValue = ''});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: TAppBar(showBackArrow: true, title: Text(isUpdate ? 'Update Address' : 'Add new Address', style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.black))),
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: EdgeInsets.all(TSizes.defaultSpace),
// //           child: Form(
// //             child: Column(
// //               children: [
// //                 TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.user), labelText: 'Name', initialValue: isUpdate ? 'Timothy Johnson' : ''), floatingLabelBehavior: FloatingLabelBehavior.always),
// //                 const SizedBox(height: TSizes.spaceBtwInputFields),
// //                 TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.mobile), labelText: 'Phone Number', initialValue: isUpdate ? '08168172808' : ''), floatingLabelBehavior: FloatingLabelBehavior.always),
// //                 const SizedBox(height: TSizes.spaceBtwInputFields),
// //                 Row(children: [Expanded(child: TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.building_31), labelText: 'Street', floatingLabelBehavior: FloatingLabelBehavior.always))), const SizedBox(width: TSizes.spaceBtwInputFields), Expanded(child: TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.code), labelText: 'Postal Code')))]),
// //                 const SizedBox(height: TSizes.spaceBtwInputFields),
// //                 Row(children: [Expanded(child: TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.building), labelText: 'City', floatingLabelBehavior: FloatingLabelBehavior.always))), const SizedBox(width: TSizes.spaceBtwInputFields), Expanded(child: TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.activity), labelText: 'State')))]),
// //                 const SizedBox(height: TSizes.spaceBtwInputFields),
// //                 TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.global), labelText: 'Country', floatingLabelBehavior: FloatingLabelBehavior.always)),
// //                 const SizedBox(height: TSizes.defaultSpace),
// //                 SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, child: Text('Save Address'))),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
// import 'package:tm_store_app/utils/constants/colors.dart';
// import 'package:tm_store_app/utils/constants/sizes.dart';
// import 'package:tm_store_app/utils/helpers/helper_functions.dart';

// class AddAndUpdateAddressScreen extends StatelessWidget {
//   final bool isUpdate;
//   final String initialValue;

//   const AddAndUpdateAddressScreen({super.key, this.isUpdate = false, this.initialValue = ''});

//   @override
//   Widget build(BuildContext context) {
//     final dark = THelperFunctions.isDarkMode(context);

//     return Scaffold(
//       //appBar: TAppBar(showBackArrow: true, title: Text(isUpdate ? 'Update Address' : 'Add new Address', style: Theme.of(context).textTheme.headlineMedium!.apply(color: dark ? Colors.white : Colors.black))),
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(kToolbarHeight), // Standard AppBar height
//         child: Container(
//           color: TColors.primary, // <-- Your desired background color
//           child: TAppBar(showBackArrow: true, title: Text(isUpdate ? 'Update Address' : 'Add new Address', style: Theme.of(context).textTheme.headlineMedium!.apply(color: dark ? TColors.dark : TColors.light))),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(TSizes.defaultSpace),
//           child: Form(
//             // ✅ Added an isolated static key to prevent the widget tree crash on updates
//             key: const ValueKey('add_new_address_form_key'),
//             child: Column(
//               children: [
//                 // Name
//                 TextFormField(initialValue: isUpdate ? 'Timothy Johnson' : '', decoration: const InputDecoration(prefixIcon: Icon(Iconsax.user), labelText: 'Name')),
//                 const SizedBox(height: TSizes.spaceBtwInputFields),

//                 // Phone Number
//                 TextFormField(initialValue: isUpdate ? '08168172808' : '', decoration: const InputDecoration(prefixIcon: Icon(Iconsax.mobile), labelText: 'Phone Number')),
//                 const SizedBox(height: TSizes.spaceBtwInputFields),

//                 // Street & Postal Code Row
//                 Row(children: [Expanded(child: TextFormField(initialValue: isUpdate ? '08168172808' : '', decoration: const InputDecoration(prefixIcon: Icon(Iconsax.building_31), labelText: 'Street'))), const SizedBox(width: TSizes.spaceBtwInputFields), Expanded(child: TextFormField(initialValue: isUpdate ? '56457' : '', decoration: const InputDecoration(prefixIcon: Icon(Iconsax.code), labelText: 'Postal Code')))]),
//                 const SizedBox(height: TSizes.spaceBtwInputFields),

//                 // City & State Row
//                 Row(children: [Expanded(child: TextFormField(initialValue: isUpdate ? 'Ilorin' : '', decoration: const InputDecoration(prefixIcon: Icon(Iconsax.building), labelText: 'City'))), const SizedBox(width: TSizes.spaceBtwInputFields), Expanded(child: TextFormField(initialValue: isUpdate ? 'Kwara' : '', decoration: const InputDecoration(prefixIcon: Icon(Iconsax.activity), labelText: 'State')))]),
//                 const SizedBox(height: TSizes.spaceBtwInputFields),

//                 // Country
//                 TextFormField(initialValue: isUpdate ? 'Nigeria' : '', decoration: const InputDecoration(prefixIcon: Icon(Iconsax.global), labelText: 'Country')),
//                 const SizedBox(height: TSizes.defaultSpace),

//                 // Submit Button
//                 SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, child: const Text('Save Address'))),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
// import 'package:tm_store_app/feastures/personalization/controllers/account_controller.dart';
// import 'package:tm_store_app/utils/constants/colors.dart';
// import 'package:tm_store_app/utils/constants/sizes.dart';
// import 'package:tm_store_app/utils/helpers/helper_functions.dart';

// class AddAndUpdateAddressScreen extends StatelessWidget {
//   final bool isUpdate;
//   final String initialValue;

//   const AddAndUpdateAddressScreen({super.key, this.isUpdate = false, this.initialValue = ''});

//   @override
//   Widget build(BuildContext context) {
//     final dark = THelperFunctions.isDarkMode(context);

//     // Registers a fresh controller instance scoped to this screen
//     final controller = Get.put(
//       AddressFormController(isUpdate: isUpdate),
//       tag: 'address_form', // avoids clashing with other instances
//     );

//     return Scaffold(
//       appBar: PreferredSize(preferredSize: const Size.fromHeight(kToolbarHeight), child: Container(color: TColors.primary, child: TAppBar(showBackArrow: true, title: Text(isUpdate ? 'Update Address' : 'Add new Address', style: Theme.of(context).textTheme.headlineMedium!.apply(color: dark ? TColors.dark : TColors.light))))),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(TSizes.defaultSpace),
//           child: Form(
//             key: controller.formKey,
//             child: Column(
//               children: [
//                 // Name
//                 TextFormField(controller: controller.nameController, decoration: const InputDecoration(prefixIcon: Icon(Iconsax.user), labelText: 'Name'), validator: (value) => (value == null || value.trim().isEmpty) ? 'Name is required' : null),
//                 const SizedBox(height: TSizes.spaceBtwInputFields),

//                 // Phone Number
//                 TextFormField(controller: controller.phoneController, keyboardType: TextInputType.phone, decoration: const InputDecoration(prefixIcon: Icon(Iconsax.mobile), labelText: 'Phone Number'), validator: (value) => (value == null || value.trim().isEmpty) ? 'Phone number is required' : null),
//                 const SizedBox(height: TSizes.spaceBtwInputFields),

//                 // Street & City Row
//                 Row(children: [Expanded(child: TextFormField(controller: controller.streetController, decoration: const InputDecoration(prefixIcon: Icon(Iconsax.building_31), labelText: 'Street'), validator: (value) => (value == null || value.trim().isEmpty) ? 'Required' : null)), const SizedBox(width: TSizes.spaceBtwInputFields),
//                  Expanded(child: TextFormField(controller: controller.cityController, keyboardType: TextInputType.number, decoration: const InputDecoration(prefixIcon: Icon(Iconsax.code), labelText: 'Postal Code'), validator: (value) => (value == null || value.trim().isEmpty) ? 'Required' : null))]),
//                 const SizedBox(height: TSizes.spaceBtwInputFields),

//                 //State & Country Row
//                 Row(children: [Expanded(child: TextFormField(controller: controller.cityController, decoration: const InputDecoration(prefixIcon: Icon(Iconsax.building), labelText: 'City'), validator: (value) => (value == null || value.trim().isEmpty) ? 'Required' : null)), const SizedBox(width: TSizes.spaceBtwInputFields), Expanded(child: TextFormField(controller: controller.stateController, decoration: const InputDecoration(prefixIcon: Icon(Iconsax.activity), labelText: 'State'), validator: (value) => (value == null || value.trim().isEmpty) ? 'Required' : null))]),
//                 const SizedBox(height: TSizes.spaceBtwInputFields),

//                 // Country
//                 TextFormField(controller: controller.countryController, decoration: const InputDecoration(prefixIcon: Icon(Iconsax.global), labelText: 'Country'), validator: (value) => (value == null || value.trim().isEmpty) ? 'Country is required' : null),
//                 const SizedBox(height: TSizes.defaultSpace),

//                 // Submit Button
//                 SizedBox(width: double.infinity, child: Obx(() => ElevatedButton(onPressed: controller.userController.isLoading.value ? null : controller.handleSubmit, child: controller.userController.isLoading.value ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Save Address')))),
//               ],
//             ),
//           ),
//         ),
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

    void handleSubmit() async {
      if (!formKey.currentState!.validate()) return;

      final updatedOrder = OrderModel(
        id: existingOrder?.id ?? controller.currentAddress.value?.id ?? '',
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
        buyerId: existingOrder?.buyerId ?? '',
        vendorId: existingOrder?.vendorId ?? '',
        image: existingOrder?.image ?? '',
        processing: existingOrder?.processing ?? true,
        delivered: existingOrder?.delivered ?? false,
      );
      if (isUpdate) {
        await controller.updateShippingAddress(
          order: updatedOrder,
          context: context,
        );
      } else {
        await controller.createShippingAddress(
          order: updatedOrder,
          context: context,
        );
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
                    labelText: 'Full Name',
                  ),
                  validator:
                      (value) =>
                          (value == null || value.trim().isEmpty)
                              ? 'Full name is required'
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
