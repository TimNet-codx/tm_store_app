// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
// import 'package:tm_store_app/common/widgets/products/cart/cart_menu_icon.dart';
// import 'package:tm_store_app/feastures/authentication/controllers/user_controller.dart';
// import 'package:tm_store_app/feastures/shop/views/cart/cart_screen.dart';
// import 'package:tm_store_app/utils/constants/colors.dart';
// import 'package:tm_store_app/utils/constants/text_strings.dart';

// class THomeAppBar extends StatelessWidget {
//   const THomeAppBar({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//       final controller = Get.find<UserController>();
//       final user = controller.user.value;
//       print("👤 User Data in AppBar: ${user != null ? 'ID: ${user.id}, Name: ${user.fullName}, Email: ${user.email}' : 'No user data available'}");
//     return TAppBar(
//       title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(TTexts.homeAppbarTitle, style: Theme.of(context).textTheme.labelMedium!.apply(color: TColors.grey ),),
//             Text( user?.fullName ?? "Loading...", style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.white ),)
//           ],
//       ),
//       actions: [
//         TCartCounterIcon(onPressed: () => Get.to(() => const CartScreen()), iconColor: TColors.white,),
//         TCartCounterIcon(onPressed: () => Get.to(() => const CartScreen()), iconColor: TColors.white,),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
import 'package:tm_store_app/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:tm_store_app/feastures/authentication/controllers/user_controller.dart';
import 'package:tm_store_app/feastures/shop/views/cart/cart_screen.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/text_strings.dart';

// class THomeAppBar extends StatelessWidget {
//   const THomeAppBar({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<UserController>();

//     // ✅ Wrap with Obx to actively listen and rebuild on value updates
//     return Obx(() {
//       final user = controller.user.value;
//       print("👤 User Data in AppBar Rebuild: ${user != null ? 'ID: ${user.id}, Name: ${user.fullName}, Email: ${user.email}' : 'No user data available'}");

//       return TAppBar(
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               TTexts.homeAppbarTitle,
//               style: Theme.of(context).textTheme.labelMedium!.apply(color: TColors.grey),
//             ),
//             Text(
//               user?.fullName ?? "Loading..",
//               style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.white),
//             )
//           ],
//         ),
//         actions: [
//           // Fixed: Removed the duplicate duplicate icon instance block row
//           TCartCounterIcon(
//             onPressed: () => Get.to(() => const CartScreen()),
//             iconColor: TColors.white,
//           ),
//         ],
//       );
//     });
//   }
// }

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Finds the controller injected by Get.put()
    final controller = Get.find<UserController>();

    return Obx(() {
      final user = controller.user.value;
      
      // Check if the controller is stuck in an async loading state
      if (controller.isLoading.value) {
        return const TAppBar(title: Text("Syncing Profile...", style: TextStyle(color: Colors.white)));
      }

      print("👤 User Data in AppBar Rebuild: ${user != null ? 'Name: ${user.fullName}, Email: ${user.email}' : 'No user data available'}");

      return TAppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              TTexts.homeAppbarTitle,
              style: Theme.of(context).textTheme.labelMedium!.apply(color: TColors.grey),
            ),
            Text(
              user?.fullName ?? "No Name Provided", // Will render if data failed to bind
              style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.white),
            )
          ],
        ),
        actions: [
          TCartCounterIcon(
            onPressed: () => Get.to(() => const CartScreen()),
            iconColor: TColors.white,
          ),
        ],
      );
    });
  }
}
