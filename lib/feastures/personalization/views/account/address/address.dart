import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
import 'package:tm_store_app/feastures/personalization/views/account/address/add_new_address.dart';
import 'package:tm_store_app/feastures/personalization/views/account/address/widgets/single_address.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';



class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        backgroundColor: TColors.primary,
        child: const Icon(Iconsax.add, color: TColors.white,),
        ),
        appBar: TAppBar(
          showBackArrow: true,
          title: Text('Addresses', style: Theme.of(context).textTheme.headlineSmall,)
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                TSingleAddress(selectedAddress: true,),
                TSingleAddress(selectedAddress: false,),
              ],
            ),
            ),
        )

        
    );
  }
}