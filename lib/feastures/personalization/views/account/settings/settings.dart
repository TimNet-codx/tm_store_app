import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
import 'package:tm_store_app/common/widgets/buttons/primary_button.dart';
import 'package:tm_store_app/common/widgets/custom_shape/container/primary_header_container.dart';
import 'package:tm_store_app/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:tm_store_app/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:tm_store_app/common/widgets/texts/section_heading.dart';
import 'package:tm_store_app/feastures/authentication/controllers/logOutUser_controller.dart';
import 'package:tm_store_app/feastures/personalization/views/account/address/address.dart';
import 'package:tm_store_app/feastures/personalization/views/account/profile/profile.dart';
import 'package:tm_store_app/feastures/shop/views/cart/cart_screen.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';


class SettingsScreen extends StatelessWidget {
   SettingsScreen({super.key});
    final controller = Get.put(SignOutUserController());

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            TPrimaryHeaderContainer(child: Column(
              children: [
                TAppBar(
                  title: Text('Account', style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.white),),
                ),
                // User Profile Card
                TUserProfileTile(onPressed: () => Get.to(()=> const ProfileScreen())),
                const SizedBox(height: TSizes.spaceBtwSections)
              ],
            )),
            // Body
            Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  // Account Settings
                  const TSectionHeading(title: 'Account Settings', showActionButton: false,),
                  const SizedBox(height: TSizes.spaceBtwItems,),
 
                  TSettingsMenuTile(icon: Iconsax.safe_home, title: 'My Addresses', subTitle: 'Set Shopping delivery address', onTap: () => Get.to(() => const UserAddressScreen()),),
                  TSettingsMenuTile(icon: Iconsax.shopping_cart, title: 'My Cart', subTitle: 'Add, remove product and move to checkout', onTap: () => Get.to(() => const CartScreen()),),
                  TSettingsMenuTile(icon: Iconsax.bag_tick, title: 'My Orders', subTitle: 'In-progress and Completed Orders', onTap: () => Get.to(() => const OrderScrern())),
                  TSettingsMenuTile(icon: Iconsax.bank, title: 'Bank Account', subTitle: 'Withdraw balance to registered bank account', onTap: (){},),
                  TSettingsMenuTile(icon: Iconsax.discount_shape, title: 'My Coupons', subTitle: 'List of all the discounted coupons', onTap: (){},),
                  TSettingsMenuTile(icon: Iconsax.notification, title: 'Notification', subTitle: 'Set any kind of notification message', onTap: (){},),
                  TSettingsMenuTile(icon: Iconsax.security_card, title: 'Account Privacy', subTitle: 'Manage data usage and connected accounts', onTap: (){},),

                 // App Settings
                 const SizedBox(height: TSizes.spaceBtwSections,),
                 const TSectionHeading(title: 'App Settings', showActionButton: false,),
                 SizedBox(height: TSizes.spaceBtwItems,),
                 TSettingsMenuTile(icon: Iconsax.document_upload, title: 'Load Data', subTitle: 'Upload Data to your Cloud Firebase', onTap: (){},),
                 TSettingsMenuTile(icon: Iconsax.location, title: 'Geolocation', subTitle: 'Set recommendation based on location', trailing: Switch(value: true, onChanged:(value){} )),
                 TSettingsMenuTile(icon: Iconsax.security_user, title: 'Safe Mode', subTitle: 'Search result is  safe all ages', trailing: Switch(value: false, onChanged:(value){} )),
                 TSettingsMenuTile(icon: Iconsax.image, title: 'HD Image Quality', subTitle: 'Set image quality to be  seen', trailing: Switch(value: false, onChanged:(value){} )),
                
                // Logout Button
                const SizedBox(height: TSizes.spaceBtwSections,),
                SizedBox(  
                  width: double.infinity,
                  child: OutlinedButton( onPressed: () => _showLogoutModal(context), child: const Text('Logout')),
                ),
                const SizedBox(height: TSizes.spaceBtwSections,),

                 
    
                ],
              ),
              )
          ],
        ),
      ),
    );

  }
    _showLogoutModal(BuildContext context) {
    Get.defaultDialog(
      title: "LOGOUT",
      titleStyle: const TextStyle(fontSize: 20),
      content: const Padding(padding: EdgeInsets.symmetric(vertical: 15.0), child: Text("Are you sure, you want to Logout?")),
      confirm: TPrimaryButton(isFullWidth: false, onPressed: ()async{await controller.signOutUser(context: context);}, text: "Yes"),
      cancel: SizedBox(width: 100, child: OutlinedButton(onPressed: () => Get.back(), child: const Text("No"))),
    );
  }
}


class OrderScrern {
  const OrderScrern();
}

