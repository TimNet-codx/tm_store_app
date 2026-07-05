import 'package:flutter/material.dart';
import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
import 'package:tm_store_app/common/widgets/texts/section_heading.dart';
import 'package:tm_store_app/utils/constants/colors.dart';

import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/helpers/helper_functions.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final controller = UserController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      // appBar: TAppBar(
      //   showBackArrow: true,
      //   title: Text('Profile'),
      // ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight), // Standard AppBar height
        child: Container(
          color: dark ? Colors.grey[900] : TColors.primary, // <-- Your desired background color
          child: TAppBar(showBackArrow: true, title: Text('Profile', style: Theme.of(context).textTheme.headlineMedium!.apply(color: dark ? TColors.dark : TColors.light))),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    // Obx((){
                    //   final networkImage = controller.user.value.profilePicture;
                    //   final image = networkImage.isNotEmpty ? networkImage : TImages.user;
                    //   return controller.imageUploading.value
                    //     ? const TShimmerEffect(width: 80, height: 80, radius: 80,)
                    //     : TCircularImage(image: image, width: 80, height: 80, isNetworkImage: networkImage.isNotEmpty);

                    // } ),
                    // TextButton(onPressed: () => controller.uploadUserProfilePicture(), child: const Text('Change Profile Picture'))
                  ],
                ),
              ),
              // Details
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Heading Profile Info
              TSectionHeading(title: 'Profile Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              // TProfileMenu(title: 'Name', value: controller.user.value.fullName, onPressed: () => Get.to(() => const ChangeName()),),
              // TProfileMenu(title: 'Username', value: controller.user.value.username , onPressed: () {},),
              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Heading Personal Info
              TSectionHeading(title: 'Personal Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              // TProfileMenu(title: 'User ID', value: controller.user.value.id, icon: Iconsax.copy, onPressed: () {},),
              // TProfileMenu(title: 'E-mail', value: controller.user.value.email, onPressed: () {},),
              // TProfileMenu(title: 'Phone Number', value: controller.user.value.phoneNumber, onPressed: () {},),
              // TProfileMenu(title: 'Gender', value: controller.user.value.gender, onPressed: () {},),
              // TProfileMenu(title: 'Date of Birth',  value: controller.user.value.dob != null
              //                       ? DateFormat('yyyy-MM-dd').format(controller.user.value.dob!)
              //                       : '', onPressed: () {},),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Center(
              //   child: TextButton(
              //     onPressed: () => controller.deleteAccountWarningPopup(),
              //      child: Text('Close/Delete Account', style: TextStyle(color: Colors.red),)
              //      ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
