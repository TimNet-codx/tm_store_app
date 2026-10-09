// import 'package:flutter/material.dart';
// import 'package:tm_store_app/feastures/personalization/views/account/address/add_new_address.dart';
// import 'package:tm_store_app/feastures/shop/models/order_model.dart';
// import 'package:tm_store_app/utils/constants/colors.dart';
// import 'package:tm_store_app/utils/helpers/helper_functions.dart';

// class SelectAddress extends StatelessWidget {
//   final OrderModel? selectedAddress;
//   const SelectAddress({super.key, this.selectedAddress});

//   @override
//   Widget build(BuildContext context) {
//     final dark = THelperFunctions.isDarkMode(context);

//     return Container(
//       height: 300,
//       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//       decoration: BoxDecoration(
//         color: dark ? TColors.dark : TColors.light,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             width: 40,
//             height: 4,
//             decoration: BoxDecoration(
//               color: Colors.grey[300],
//               borderRadius: BorderRadius.circular(2),
//             ),
//           ),
//           const SizedBox(height: 24),
//           const Text(
//             'Select Address',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 24),
//           _buildAddressCard(context, selectedAddress),
//           const SizedBox(height: 24),
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF2563EB),
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 elevation: 0,
//               ),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder:
//                         (context) => const AddAndUpdateShippingAddressScreen(
//                           isUpdate: false,
//                         ),
//                   ),
//                 );
//               },
//               child: const Text(
//                 'Add new address',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// Widget _buildAddressCard(BuildContext context, OrderModel? selectedAddress) {
//   final dark = THelperFunctions.isDarkMode(context);
//   final fullName = selectedAddress?.fullName ?? 'No Name Provided';
//   final phone = selectedAddress?.phoneNumber ?? '';
//   final formattedAddress =
//       selectedAddress != null
//           ? '${selectedAddress.street}, ${selectedAddress.city}, ${selectedAddress.state} ${selectedAddress.postalCode}'
//           : '';

//   return Container(
//     padding: const EdgeInsets.all(16),
//     decoration: BoxDecoration(
//       color: dark ? TColors.dark : TColors.light,
//       borderRadius: BorderRadius.circular(16),
//     ),
//     child: Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Radio(
//           value: true,
//           groupValue: true,
//           onChanged: (v) {},
//           activeColor: TColors.primary,
//         ),
//         const SizedBox(width: 8),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 fullName,
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//               ),
//               const SizedBox(height: 8),
//               Text(phone, style: TextStyle(color: Colors.grey[600])),
//               const SizedBox(height: 4),
//               Text(formattedAddress, style: TextStyle(color: Colors.grey[600])),
//             ],
//           ),
//         ),
//         GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder:
//                     (context) => AddAndUpdateShippingAddressScreen(
//                       isUpdate: true,
//                       existingOrder:
//                           selectedAddress, // Pass the existing data for update
//                     ),
//               ),
//             );
//           },
//           child: Container(
//             padding: const EdgeInsets.all(8),
//             decoration: const BoxDecoration(
//               color: TColors.primary,
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(Icons.edit, color: Colors.white, size: 16),
//           ),
//         ),
//       ],
//     ),
//   );
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tm_store_app/feastures/personalization/views/account/address/add_new_address.dart';
// import 'package:tm_store_app/feastures/shop/controllers/order_controller.dart';
// import 'package:tm_store_app/feastures/shop/models/order_model.dart';
// import 'package:tm_store_app/utils/constants/colors.dart';
// import 'package:tm_store_app/utils/helpers/helper_functions.dart';

// class SelectAddress extends StatelessWidget {
//   final OrderModel? selectedAddress;

//   const SelectAddress({super.key, this.selectedAddress});

//   @override
//   Widget build(BuildContext context) {
//     final dark = THelperFunctions.isDarkMode(context);
//     final controller = Get.find<OrderController>();
//     if (controller.orderM.isEmpty) {
//       controller.fetchOrders();
//     }

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//       decoration: BoxDecoration(
//         color: dark ? TColors.dark : TColors.light,
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
//       ),
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: 40,
//               height: 4,
//               decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 borderRadius: BorderRadius.circular(2),
//               ),
//             ),
//             const SizedBox(height: 24),
//             const Text(
//               'Select Address',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 24),

//             // Observe GetX controller state reactively
//             Obx(() {
//               if (controller.isLoading.value) {
//                 return const Center(child: CircularProgressIndicator());
//               }

//               if (controller.orderM.isEmpty) {
//                 return const Padding(
//                   padding: EdgeInsets.symmetric(vertical: 16.0),
//                   child: Text('No shipping address found.'),
//                 );
//               }

//               // Use passed prop or fallback to first order item
//               final OrderModel targetAddress =
//                   selectedAddress ?? controller.orderM.first;

//               return _buildAddressCard(context, targetAddress);
//             }),

//             const SizedBox(height: 24),
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
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder:
//                           (context) => const AddAndUpdateShippingAddressScreen(
//                             isUpdate: false,
//                           ),
//                     ),
//                   );
//                 },
//                 child: const Text(
//                   'Add new address',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAddressCard(BuildContext context, OrderModel address) {
//     final dark = THelperFunctions.isDarkMode(context);
//     final fullName =
//         address.fullName.isNotEmpty ? address.fullName : 'No Name Provided';
//     final phone = address.phoneNumber ?? '';
//     final formattedAddress =
//         '${address.street}, ${address.city}, ${address.state} ${address.postalCode}';

//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: dark ? TColors.dark : TColors.light,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.grey.withOpacity(0.2)),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Radio<bool>(
//             value: true,
//             groupValue: true,
//             onChanged: (v) {},
//             activeColor: TColors.primary,
//           ),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   fullName,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//                 if (phone.isNotEmpty) ...[
//                   const SizedBox(height: 8),
//                   Text(phone, style: TextStyle(color: Colors.grey[600])),
//                 ],
//                 const SizedBox(height: 4),
//                 Text(
//                   formattedAddress,
//                   style: TextStyle(color: Colors.grey[600]),
//                 ),
//               ],
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder:
//                       (context) => AddAndUpdateShippingAddressScreen(
//                         isUpdate: true,
//                         existingOrder: address,
//                       ),
//                 ),
//               );
//             },
//             child: Container(
//               padding: const EdgeInsets.all(8),
//               decoration: const BoxDecoration(
//                 color: TColors.primary,
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(Icons.edit, color: Colors.white, size: 16),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tm_store_app/feastures/personalization/views/account/address/add_new_address.dart';
// import 'package:tm_store_app/feastures/shop/controllers/order_controller.dart';
// import 'package:tm_store_app/feastures/shop/models/order_model.dart';
// import 'package:tm_store_app/utils/constants/colors.dart';
// import 'package:tm_store_app/utils/helpers/helper_functions.dart';

// class SelectAddress extends StatelessWidget {
//   final OrderModel? selectedAddress;
//   final String buyerId;

//   const SelectAddress({
//     super.key,
//     this.selectedAddress,
//     required this.buyerId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final dark = THelperFunctions.isDarkMode(context);

//     // Reuse the tagged controller if it exists, otherwise create it for this buyer
//     final controller = Get.put(
//       OrderController(buyerId: buyerId),
//       tag: 'order_address_form',
//     );

//     if (controller.orderM.isEmpty) {
//       controller.fetchOrders(buyerId: buyerId);
//     }

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//       decoration: BoxDecoration(
//         color: dark ? TColors.dark : TColors.light,
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
//       ),
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: 40,
//               height: 4,
//               decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 borderRadius: BorderRadius.circular(2),
//               ),
//             ),
//             const SizedBox(height: 24),
//             const Text(
//               'Select Address',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 24),

//             // Observe GetX controller state reactively
//             Obx(() {
//               if (controller.isLoading.value) {
//                 return const Center(child: CircularProgressIndicator());
//               }

//               if (controller.orderM.isEmpty) {
//                 return const Padding(
//                   padding: EdgeInsets.symmetric(vertical: 16.0),
//                   child: Text('No shipping address found.'),
//                 );
//               }

//               // Use passed prop or fallback to first order item
//               final OrderModel targetAddress =
//                   selectedAddress ?? controller.orderM.first;

//               return _buildAddressCard(context, targetAddress);
//             }),

//             const SizedBox(height: 24),
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
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder:
//                           (context) => AddAndUpdateShippingAddressScreen(
//                             isUpdate: false,
//                             buyerId: buyerId,
//                           ),
//                     ),
//                   );
//                 },
//                 child: const Text(
//                   'Add new address',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAddressCard(BuildContext context, OrderModel address) {
//     final dark = THelperFunctions.isDarkMode(context);
//     final fullName =
//         address.fullName.isNotEmpty ? address.fullName : 'No Name Provided';
//     final phone = address.phoneNumber;
//     final formattedAddress =
//         '${address.street}, ${address.city}, ${address.state} ${address.postalCode}';

//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: dark ? TColors.dark : TColors.light,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.grey.withOpacity(0.2)),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Radio<bool>(
//             value: true,
//             groupValue: true,
//             onChanged: (v) {},
//             activeColor: TColors.primary,
//           ),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   fullName,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//                 if (phone.isNotEmpty) ...[
//                   const SizedBox(height: 8),
//                   Text(phone, style: TextStyle(color: Colors.grey[600])),
//                 ],
//                 const SizedBox(height: 4),
//                 Text(
//                   formattedAddress,
//                   style: TextStyle(color: Colors.grey[600]),
//                 ),
//               ],
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder:
//                       (context) => AddAndUpdateShippingAddressScreen(
//                         isUpdate: true,
//                         buyerId: buyerId,
//                         existingOrder: address,
//                       ),
//                 ),
//               );
//             },
//             child: Container(
//               padding: const EdgeInsets.all(8),
//               decoration: const BoxDecoration(
//                 color: TColors.primary,
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(Icons.edit, color: Colors.white, size: 16),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tm_store_app/feastures/personalization/views/account/address/add_new_address.dart';
// import 'package:tm_store_app/feastures/shop/controllers/order_controller.dart';
// import 'package:tm_store_app/feastures/shop/models/order_model.dart';
// import 'package:tm_store_app/utils/constants/colors.dart';
// import 'package:tm_store_app/utils/helpers/helper_functions.dart';

// class SelectAddress extends StatefulWidget {
//   final OrderModel? selectedAddress;
//   final String buyerId;

//   const SelectAddress({super.key, this.selectedAddress, required this.buyerId});

//   @override
//   State<SelectAddress> createState() => _SelectAddressState();
// }

// class _SelectAddressState extends State<SelectAddress> {
//   late final OrderController controller;

//   // Tracks which address is currently chosen, by its id
//   String? selectedId;

//   @override
//   void initState() {
//     super.initState();

//     controller = Get.put(
//       OrderController(buyerId: widget.buyerId),
//       tag: 'order_address_form',
//     );

//     if (controller.orderM.isEmpty) {
//       controller.fetchOrders(buyerId: widget.buyerId);
//     }

//     selectedId = widget.selectedAddress?.id;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final dark = THelperFunctions.isDarkMode(context);

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//       decoration: BoxDecoration(
//         color: dark ? TColors.dark : TColors.light,
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
//       ),
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: 40,
//               height: 4,
//               decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 borderRadius: BorderRadius.circular(2),
//               ),
//             ),
//             const SizedBox(height: 24),
//             const Text(
//               'Select Address',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 24),

//             // Observe GetX controller state reactively
//             Obx(() {
//               if (controller.isLoading.value) {
//                 return const Padding(
//                   padding: EdgeInsets.symmetric(vertical: 24),
//                   child: Center(child: CircularProgressIndicator()),
//                 );
//               }

//               if (controller.orderM.isEmpty) {
//                 return const Padding(
//                   padding: EdgeInsets.symmetric(vertical: 16.0),
//                   child: Text('No shipping address found.'),
//                 );
//               }

//               // Default to the first address if nothing selected yet
//               selectedId ??= controller.orderM.first.id;

//               return Column(
//                 children:
//                     controller.orderM.map((address) {
//                       final isSelected = address.id == selectedId;
//                       return Padding(
//                         padding: const EdgeInsets.only(bottom: 12),
//                         child: _buildAddressCard(
//                           context,
//                           address,
//                           isSelected: isSelected,
//                           onSelect: () {
//                             setState(() {
//                               selectedId = address.id;
//                             });
//                           },
//                         ),
//                       );
//                     }).toList(),
//               );
//             }),

//             const SizedBox(height: 12),

//             // Confirm selection and return it to the caller
//             SizedBox(
//               width: double.infinity,
//               child: OutlinedButton(
//                 style: OutlinedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 onPressed: () {
//                   final chosen = controller.orderM.firstWhereOrNull(
//                     (e) => e.id == selectedId,
//                   );
//                   if (chosen != null) {
//                     Navigator.pop(context, chosen);
//                   }
//                 },
//                 child: const Text(
//                   'Use this address',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 12),
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
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder:
//                           (context) => AddAndUpdateShippingAddressScreen(
//                             isUpdate: false,
//                             buyerId: widget.buyerId,
//                           ),
//                     ),
//                   );
//                 },
//                 child: const Text(
//                   'Add new address',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAddressCard(
//     BuildContext context,
//     OrderModel address, {
//     required bool isSelected,
//     required VoidCallback onSelect,
//   }) {
//     final dark = THelperFunctions.isDarkMode(context);
//     final fullName =
//         address.fullName.isNotEmpty ? address.fullName : 'No Name Provided';
//     final phone = address.phoneNumber;
//     final formattedAddress =
//         '${address.street}, ${address.city}, ${address.state} ${address.postalCode}';

//     return GestureDetector(
//       onTap: onSelect,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: dark ? TColors.dark : TColors.light,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(
//             color: isSelected ? TColors.primary : Colors.grey.withOpacity(0.2),
//             width: isSelected ? 2 : 1,
//           ),
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Radio<String>(
//               value: address.id,
//               groupValue: selectedId,
//               onChanged: (_) => onSelect(),
//               activeColor: TColors.primary,
//             ),
//             const SizedBox(width: 8),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     fullName,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                   if (phone.isNotEmpty) ...[
//                     const SizedBox(height: 8),
//                     Text(phone, style: TextStyle(color: Colors.grey[600])),
//                   ],
//                   const SizedBox(height: 4),
//                   Text(
//                     formattedAddress,
//                     style: TextStyle(color: Colors.grey[600]),
//                   ),
//                 ],
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder:
//                         (context) => AddAndUpdateShippingAddressScreen(
//                           isUpdate: true,
//                           buyerId: widget.buyerId,
//                           existingOrder: address,
//                         ),
//                   ),
//                 );
//               },
//               child: Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: const BoxDecoration(
//                   color: TColors.primary,
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(Icons.edit, color: Colors.white, size: 16),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_store_app/feastures/personalization/views/account/address/add_new_address.dart';
import 'package:tm_store_app/feastures/shop/controllers/order_controller.dart';
import 'package:tm_store_app/feastures/shop/models/order_model.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/helpers/helper_functions.dart';

class SelectAddress extends StatelessWidget {
  final OrderModel? selectedAddress;
  final String buyerId;

  const SelectAddress({super.key, this.selectedAddress, required this.buyerId});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    const tag = 'order_address_form';
    final controller =
        Get.isRegistered<OrderController>(tag: tag)
            ? Get.find<OrderController>(tag: tag)
            : Get.put(OrderController(buyerId: buyerId), tag: tag);

    if (controller.orderM.isEmpty) {
      controller.fetchOrders(buyerId: buyerId);
    }

    // Seed the initial selection once, if one was passed in
    if (selectedAddress != null && controller.selectedAddressId.value == null) {
      controller.selectedAddressId.value = selectedAddress!.id;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: dark ? TColors.dark : TColors.light,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Select Address',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            Obx(() {
              if (controller.isLoading.value) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (controller.orderM.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text('No shipping address found.'),
                );
              }

              // Safely ensure a default selection if none exists
              if (controller.selectedAddressId.value == null &&
                  controller.orderM.isNotEmpty) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  controller.selectedAddressId.value =
                      controller.orderM.first.id;
                });
              }

              return Column(
                children:
                    controller.orderM.map((address) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildAddressCard(context, controller, address),
                      );
                    }).toList(),
              );
            }),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  final chosen = controller.orderM.firstWhereOrNull(
                    (e) => e.id == controller.selectedAddressId.value,
                  );
                  if (chosen != null) {
                    // update local reactive state immediately
                    controller.currentAddress.value = chosen;
                    controller.selectedAddressId.value = chosen.id;
                    // Persist to DB first
                    await controller.selectShippingAddress(chosen);

                    if (context.mounted) {
                      Navigator.pop(context, chosen);
                    }
                  }
                },
                child: const Text(
                  'Use this address',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => AddAndUpdateShippingAddressScreen(
                            isUpdate: false,
                            buyerId: buyerId,
                          ),
                    ),
                  );
                },
                child: const Text(
                  'Add new address',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressCard(
    BuildContext context,
    OrderController controller,
    OrderModel address,
  ) {
    final dark = THelperFunctions.isDarkMode(context);
    final fullName =
        address.fullName.isNotEmpty ? address.fullName : 'No Name Provided';
    final phone = address.phoneNumber;
    final formattedAddress =
        '${address.street}, ${address.city}, ${address.state} ${address.postalCode}';

    // Wrap in Obx so clicking updates this specific card's UI dynamically
    return Obx(() {
      final isSelected = controller.selectedAddressId.value == address.id;

      return GestureDetector(
        onTap: () => controller.selectedAddressId.value = address.id,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: dark ? TColors.dark : TColors.light,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color:
                  isSelected ? TColors.primary : Colors.grey.withOpacity(0.2),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Radio<String>(
                value: address.id,
                groupValue: controller.selectedAddressId.value,
                onChanged: (value) {
                  if (value != null) {
                    controller.selectedAddressId.value = value;
                  }
                },
                activeColor: TColors.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fullName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    if (phone.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(phone, style: TextStyle(color: Colors.grey[600])),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      formattedAddress,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              // Edit & Delete Actions Column
              Column(
                children: [
                  // Edit Button
                  GestureDetector(
                    onTap: () async {
                      controller.selectedAddressId.value = address.id;
                      controller.prefillFormFields(address);
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => AddAndUpdateShippingAddressScreen(
                                isUpdate: true,
                                buyerId: buyerId,
                                existingOrder: address,
                              ),
                        ),
                      );
                      await controller.fetchOrders(buyerId: buyerId);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: TColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Delete Button
                  GestureDetector(
                    onTap: () {
                      _showDeleteConfirmationDialog(
                        context,
                        controller,
                        address.id,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.delete_outline,
                        color: Colors.red.shade600,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

/// Confirmation Dialog for Deleting Address
void _showDeleteConfirmationDialog(
  BuildContext context,
  OrderController controller,
  String orderId,
) {
  showDialog(
    context: context,
    builder: (BuildContext ctx) {
      return AlertDialog(
        title: const Text('Delete Address'),
        content: const Text('Are you sure you want to delete this address?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              controller.deleteShippingAddress(
                orderId: orderId,
                context: context,
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}
