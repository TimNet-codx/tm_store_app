// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tm_store_app/common/widgets/texts/section_heading.dart';
// import 'package:tm_store_app/feastures/authentication/controllers/user_controller.dart';
// import 'package:tm_store_app/feastures/shop/controllers/order_controller.dart';
// import 'package:tm_store_app/feastures/shop/views/checkout/widgets/seletectAddress.dart';
// import 'package:tm_store_app/utils/constants/sizes.dart';

// class TBillingAddressSection extends StatelessWidget {
//   const TBillingAddressSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final userController = Get.find<UserController>();
//     final buyerId = userController.user.value?.id ?? '';

//       // Shares the same controller instance/tag as SelectAddress
//     final OrderController controller = Get.put(
//       OrderController(buyerId: buyerId),
//       tag: 'order_address_form',
//     );

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         GestureDetector(
//           child: TSectionHeading(
//             title: "Shipping  Address",
//             buttonTitle: 'Change',
//             onPerssed: () => _showSelectAddress(context),
//           ),
//         ),
//         Text("T's Store", style: Theme.of(context).textTheme.bodyLarge),
//         const SizedBox(height: TSizes.spaceBtwItems / 2),
//         Row(
//           children: [
//             const Icon(Icons.phone, color: Colors.grey, size: 16),
//             const SizedBox(width: TSizes.spaceBtwItems),
//             Text('+34678787236', style: Theme.of(context).textTheme.bodyMedium),
//           ],
//         ),
//         const SizedBox(height: TSizes.spaceBtwItems / 2),
//         Row(
//           children: [
//             const Icon(Icons.location_history, color: Colors.grey, size: 16),
//             const SizedBox(width: TSizes.spaceBtwItems),
//             Expanded(
//               child: Text(
//                 'South Liana, Kwara, 32467 USA',
//                 style: Theme.of(context).textTheme.bodyMedium,
//                 softWrap: true,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// // void _showSelectAddress(BuildContext context) {
// //   showModalBottomSheet(
// //     context: context,
// //     isScrollControlled: true,
// //     backgroundColor: Colors.transparent,
// //     builder: (context) => const SelectAddress(buyerId: '<BUYER_ID>'),
// //   );
// // }

// void _showSelectAddress(BuildContext context) {
//   final userController = Get.find<UserController>();
//   final buyerId = userController.user.value?.id;

//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     builder: (context) => SelectAddress(buyerId: buyerId!),
//   );
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_store_app/common/widgets/texts/section_heading.dart';
import 'package:tm_store_app/feastures/authentication/controllers/user_controller.dart';
import 'package:tm_store_app/feastures/shop/controllers/order_controller.dart';
import 'package:tm_store_app/feastures/shop/models/order_model.dart';
import 'package:tm_store_app/feastures/shop/views/checkout/widgets/seletectAddress.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';

class TBillingAddressSection extends StatelessWidget {
  const TBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    final buyerId = userController.user.value?.id ?? '';

    // Shares the same controller instance/tag as SelectAddress
    const tag = 'order_address_form';
    final OrderController controller =
        Get.isRegistered<OrderController>(tag: tag)
            ? Get.find<OrderController>(tag: tag)
            : Get.put(OrderController(buyerId: buyerId), tag: tag);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          child: TSectionHeading(
            title: "Shipping  Address",
            buttonTitle: 'Change',
            onPerssed: () => _showSelectAddress(context, buyerId, controller),
          ),
        ),

        // Reactively reflects whichever address is currently selected
        Obx(() {
          final address = controller.currentAddress.value;

          if (controller.isLoading.value && address == null) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: CircularProgressIndicator(),
            );
          }
          if (address == null) {
            return Text(
              'No shipping address selected',
              style: Theme.of(context).textTheme.bodyMedium,
            );
          }

          final formattedAddress =
              '${address.street}, ${address.city}, ${address.state} ${address.postalCode}, ${address.country}';

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                address.fullName.isNotEmpty ? address.fullName : "T's Store",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              if (address.phoneNumber.isNotEmpty)
                Row(
                  children: [
                    const Icon(Icons.phone, color: Colors.grey, size: 16),
                    const SizedBox(width: TSizes.spaceBtwItems),
                    Text(
                      address.phoneNumber,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              Row(
                children: [
                  const Icon(
                    Icons.location_history,
                    color: Colors.grey,
                    size: 16,
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Expanded(
                    child: Text(
                      formattedAddress,
                      style: Theme.of(context).textTheme.bodyMedium,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ],
    );
  }
}

void _showSelectAddress(
  BuildContext context,
  String buyerId,
  OrderController controller,
) async {
  final selected = await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => SelectAddress(
          buyerId: buyerId,
          selectedAddress: controller.currentAddress.value,
        ),
  );

  // if (selected != null && selected is OrderModel) {
  //   controller.currentAddress.value = selected;
  // }
  if (selected != null && selected is OrderModel) {
    // controller.selectShippingAddress(selected);
    controller.currentAddress.value = selected;
    controller.selectedAddressId.value = selected.id;
  }
}
