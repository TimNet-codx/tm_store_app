// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:iconsax/iconsax.dart';
// // import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
// // import 'package:tm_store_app/feastures/personalization/controllers/account_controller.dart';
// // import 'package:tm_store_app/feastures/shop/controllers/order_controller.dart';
// // import 'package:tm_store_app/utils/constants/colors.dart';
// // import 'package:tm_store_app/utils/constants/sizes.dart';
// // import 'package:tm_store_app/utils/helpers/helper_functions.dart';

// // class AddAndUpdateOrderAddressScreen extends StatelessWidget {
// //   final bool isUpdate;
// //   final String initialValue;

// //   const AddAndUpdateOrderAddressScreen({super.key, this.isUpdate = false, this.initialValue = ''});

// //   @override
// //   Widget build(BuildContext context) {
// //     final dark = THelperFunctions.isDarkMode(context);

// //     // Registers a fresh controller instance scoped to this screen
// //     final controller = Get.put(
// //       OrderController(isUpdate: isUpdate),
// //       tag: 'address_form', // avoids clashing with other instances
// //     );

// //     return Scaffold(
// //       appBar: PreferredSize(preferredSize: const Size.fromHeight(kToolbarHeight), child: Container(color: TColors.primary, child: TAppBar(showBackArrow: true, title: Text(isUpdate ? 'Update Address' : 'Add new Address', style: Theme.of(context).textTheme.headlineMedium!.apply(color: dark ? TColors.dark : TColors.light))))),
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: const EdgeInsets.all(TSizes.defaultSpace),
// //           child: Form(
// //             key: controller.formKey,
// //             child: Column(
// //               children: [
// //                 // Name
// //                 TextFormField(controller: controller.nameController, decoration: const InputDecoration(prefixIcon: Icon(Iconsax.user), labelText: 'Name'), validator: (value) => (value == null || value.trim().isEmpty) ? 'Name is required' : null),
// //                 const SizedBox(height: TSizes.spaceBtwInputFields),

// //                 // Phone Number
// //                 TextFormField(controller: controller.phoneController, keyboardType: TextInputType.phone, decoration: const InputDecoration(prefixIcon: Icon(Iconsax.mobile), labelText: 'Phone Number'), validator: (value) => (value == null || value.trim().isEmpty) ? 'Phone number is required' : null),
// //                 const SizedBox(height: TSizes.spaceBtwInputFields),

// //                 // Street & Postal Code Row
// //                 Row(children: [Expanded(child: TextFormField(controller: controller.streetController, decoration: const InputDecoration(prefixIcon: Icon(Iconsax.building_31), labelText: 'Street'), validator: (value) => (value == null || value.trim().isEmpty) ? 'Required' : null)), const SizedBox(width: TSizes.spaceBtwInputFields), Expanded(child: TextFormField(controller: controller.postalCodeController, keyboardType: TextInputType.number, decoration: const InputDecoration(prefixIcon: Icon(Iconsax.code), labelText: 'Postal Code'), validator: (value) => (value == null || value.trim().isEmpty) ? 'Required' : null))]),
// //                 const SizedBox(height: TSizes.spaceBtwInputFields),

// //                 // City & State Row
// //                 Row(children: [Expanded(child: TextFormField(controller: controller.cityController, decoration: const InputDecoration(prefixIcon: Icon(Iconsax.building), labelText: 'City'), validator: (value) => (value == null || value.trim().isEmpty) ? 'Required' : null)), const SizedBox(width: TSizes.spaceBtwInputFields), Expanded(child: TextFormField(controller: controller.stateController, decoration: const InputDecoration(prefixIcon: Icon(Iconsax.activity), labelText: 'State'), validator: (value) => (value == null || value.trim().isEmpty) ? 'Required' : null))]),
// //                 const SizedBox(height: TSizes.spaceBtwInputFields),

// //                 // Country
// //                 TextFormField(controller: controller.countryController, decoration: const InputDecoration(prefixIcon: Icon(Iconsax.global), labelText: 'Country'), validator: (value) => (value == null || value.trim().isEmpty) ? 'Country is required' : null),
// //                 const SizedBox(height: TSizes.defaultSpace),

// //                 // Submit Button
// //                 SizedBox(width: double.infinity, child: Obx(() => ElevatedButton(onPressed: controller.userController.isLoading.value ? null : controller.handleSubmit, child: controller.userController.isLoading.value ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Save Address')))),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:tm_store_app/common/widgets/appbar/appbar.dart' show TAppBar;
// import 'package:tm_store_app/feastures/shop/controllers/order_controller.dart';
// import 'package:tm_store_app/feastures/shop/models/order_model.dart';
// import 'package:tm_store_app/utils/constants/colors.dart';
// import 'package:tm_store_app/utils/constants/sizes.dart';
// import 'package:tm_store_app/utils/helpers/helper_functions.dart';

// class AddAndUpdateOrderAddressScreen extends StatelessWidget {
//   final bool isUpdate;
//   final OrderModel? existingOrder;

//   const AddAndUpdateOrderAddressScreen({
//     super.key,
//     this.isUpdate = false,
//     this.existingOrder,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final dark = THelperFunctions.isDarkMode(context);
//     final formKey = GlobalKey<FormState>();

//     // Retrieve or register OrderController instance
//     final orderController = Get.put(OrderController(isUpdate: isUpdate));

//     // Initialize Text Controllers with existing values if updating
//     final fullNameController = TextEditingController(
//       text: existingOrder?.fullName ?? '',
//     );
//     final emailController = TextEditingController(
//       text: existingOrder?.email ?? '',
//     );
//     final streetController = TextEditingController(
//       text: existingOrder?.street ?? '',
//     );
//     final cityController = TextEditingController(
//       text: existingOrder?.city ?? '',
//     );
//     final stateController = TextEditingController(
//       text: existingOrder?.state ?? '',
//     );
//     final productNameController = TextEditingController(
//       text: existingOrder?.productName ?? '',
//     );
//     final productPriceController = TextEditingController(
//       text: existingOrder?.productPrice?.toString() ?? '',
//     );
//     final quantityController = TextEditingController(
//       text: existingOrder?.quantity?.toString() ?? '1',
//     );

//     void submitForm() {
//       if (!formKey.currentState!.validate()) return;

//       final orderPayload = OrderModel(
//         id: existingOrder?.id ?? '',
//         fullName: fullNameController.text.trim(),
//         email: emailController.text.trim(),
//         street: streetController.text.trim(),
//         city: cityController.text.trim(),
//         state: stateController.text.trim(),
//         productName: productNameController.text.trim(),
//         // productPrice: int.tryParse(productPriceController.text.trim()) ?? 0,
//         quantity: int.tryParse(quantityController.text.trim()) ?? 1,
//         category: existingOrder?.category ?? 'General',
//         image: existingOrder?.image ?? '',
//         buyerId: existingOrder?.buyerId ?? '',
//         vendorId: existingOrder?.vendorId ?? '',
//         processing: false,
//         delivered: false,
//       );

//       if (isUpdate) {
//        // orderController.updateOrder(order: orderPayload, context: context);
//       } else {
//         //orderController.createOrder(order: orderPayload, context: context);
//       }
//     }

//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(kToolbarHeight),
//         child: Container(
//           color: TColors.primary,
//           child: TAppBar(
//             showBackArrow: true,
//             title: Text(
//               isUpdate ? 'Update Order Details' : 'Add New Order',
//               style: Theme.of(context).textTheme.headlineMedium!.apply(
//                 color: dark ? TColors.dark : TColors.light,
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(TSizes.defaultSpace),
//           child: Form(
//             key: formKey,
//             child: Column(
//               children: [
//                 // Full Name
//                 TextFormField(
//                   controller: fullNameController,
//                   decoration: const InputDecoration(
//                     prefixIcon: Icon(Iconsax.user),
//                     labelText: 'Full Name',
//                   ),
//                   validator:
//                       (value) =>
//                           (value == null || value.trim().isEmpty)
//                               ? 'Name is required'
//                               : null,
//                 ),
//                 const SizedBox(height: TSizes.spaceBtwInputFields),

//                 // Email
//                 TextFormField(
//                   controller: emailController,
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: const InputDecoration(
//                     prefixIcon: Icon(Iconsax.sms),
//                     labelText: 'Email Address',
//                   ),
//                   validator:
//                       (value) =>
//                           (value == null || value.trim().isEmpty)
//                               ? 'Email is required'
//                               : null,
//                 ),
//                 const SizedBox(height: TSizes.spaceBtwInputFields),

//                 // Street Address
//                 TextFormField(
//                   controller: streetController,
//                   decoration: const InputDecoration(
//                     prefixIcon: Icon(Iconsax.building_31),
//                     labelText: 'Street Address',
//                   ),
//                   validator:
//                       (value) =>
//                           (value == null || value.trim().isEmpty)
//                               ? 'Street is required'
//                               : null,
//                 ),
//                 const SizedBox(height: TSizes.spaceBtwInputFields),

//                 // City & State Row
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextFormField(
//                         controller: cityController,
//                         decoration: const InputDecoration(
//                           prefixIcon: Icon(Iconsax.building),
//                           labelText: 'City',
//                         ),
//                         validator:
//                             (value) =>
//                                 (value == null || value.trim().isEmpty)
//                                     ? 'City required'
//                                     : null,
//                       ),
//                     ),
//                     const SizedBox(width: TSizes.spaceBtwInputFields),
//                     Expanded(
//                       child: TextFormField(
//                         controller: stateController,
//                         decoration: const InputDecoration(
//                           prefixIcon: Icon(Iconsax.activity),
//                           labelText: 'State',
//                         ),
//                         validator:
//                             (value) =>
//                                 (value == null || value.trim().isEmpty)
//                                     ? 'State required'
//                                     : null,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: TSizes.spaceBtwInputFields),

//                 // Product Name
//                 TextFormField(
//                   controller: productNameController,
//                   decoration: const InputDecoration(
//                     prefixIcon: Icon(Iconsax.box),
//                     labelText: 'Product Name',
//                   ),
//                   validator:
//                       (value) =>
//                           (value == null || value.trim().isEmpty)
//                               ? 'Product name is required'
//                               : null,
//                 ),
//                 const SizedBox(height: TSizes.spaceBtwInputFields),

//                 // Price & Quantity Row
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextFormField(
//                         controller: productPriceController,
//                         keyboardType: TextInputType.number,
//                         decoration: const InputDecoration(
//                           prefixIcon: Icon(Iconsax.money),
//                           labelText: 'Price',
//                         ),
//                         validator:
//                             (value) =>
//                                 (value == null || value.trim().isEmpty)
//                                     ? 'Price required'
//                                     : null,
//                       ),
//                     ),
//                     const SizedBox(width: TSizes.spaceBtwInputFields),
//                     Expanded(
//                       child: TextFormField(
//                         controller: quantityController,
//                         keyboardType: TextInputType.number,
//                         decoration: const InputDecoration(
//                           prefixIcon: Icon(Iconsax.shopping_cart),
//                           labelText: 'Quantity',
//                         ),
//                         validator:
//                             (value) =>
//                                 (value == null || value.trim().isEmpty)
//                                     ? 'Quantity required'
//                                     : null,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: TSizes.defaultSpace),

//                 // Submit Button
//                 SizedBox(
//                   width: double.infinity,
//                   child: Obx(
//                     () => ElevatedButton(
//                       onPressed:
//                           orderController.isLoading.value ? null : submitForm,
//                       child:
//                           orderController.isLoading.value
//                               ? const SizedBox(
//                                 height: 20,
//                                 width: 20,
//                                 child: CircularProgressIndicator(
//                                   strokeWidth: 2,
//                                 ),
//                               )
//                               : Text(
//                                 isUpdate ? 'Update Order' : 'Submit Order',
//                               ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
