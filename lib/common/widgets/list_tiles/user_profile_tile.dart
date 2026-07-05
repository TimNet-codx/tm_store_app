import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tm_store_app/common/widgets/images/t_circular_image.dart';
import 'package:tm_store_app/feastures/authentication/controllers/user_controller.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/image_strings.dart';

// class TUserProfileTile extends StatelessWidget {
//   const   TUserProfileTile({
//     super.key, required this.onPressed,
//   });
//   final Function() onPressed;

//   @override
//   Widget build(BuildContext context) {
//    final controller = UserController.instance;
//     return ListTile(
//       leading: const TCircularImage(image: TImages.user, width: 50, height: 50, padding: 0,),
//       title: Text(
//         // controller.user.value.fullName,
//         userData?.fullName.isEmpty ?? true ? "Loading..." : userData!.fullName,
//         style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white),),
//       subtitle: Text(
//         // controller.email.value,
//         controller.user?.email ?? "user@example.com",
//          style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white),),
//       trailing: IconButton(onPressed: onPressed, icon: const Icon(Iconsax.edit, color: TColors.white,)),
//     );
//   }
// }

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({super.key, required this.onPressed});

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    //  final controller = UserController.instance;
    final controller = Get.find<UserController>();

    // ✅ Wrap with Obx to listen for changes in the user controller
    return Obx(() {
      // Access the user value from the observable
      //final userData = controller.user.value;
      final userData = controller.user.value;
      return ListTile(
        leading: const TCircularImage(image: TImages.user, width: 50, height: 50, padding: 0),
        title: Text(
          // ✅ Use null-aware operators and fallback values
          userData?.fullName ?? "Loading...",
          style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white),
        ),
        subtitle: Text(userData?.email ?? "", style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white)),
        trailing: IconButton(onPressed: onPressed, icon: const Icon(Iconsax.edit, color: TColors.white)),
      );
    });
  }
}
