import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
import 'package:tm_store_app/common/widgets/custom_shape/container/rounded_container.dart';
import 'package:tm_store_app/common/widgets/products/cart/coupon_widget.dart';
import 'package:tm_store_app/common/widgets/success_screen/success_screen.dart';
import 'package:tm_store_app/feastures/shop/views/cart/widgets/cart_items.dart';
import 'package:tm_store_app/feastures/shop/views/checkout/widgets/billing_address_section.dart';
import 'package:tm_store_app/feastures/shop/views/checkout/widgets/billing_amount_section.dart';
import 'package:tm_store_app/feastures/shop/views/checkout/widgets/billing_payment_section.dart';
import 'package:tm_store_app/main_screen.dart';
import 'package:tm_store_app/provider/cart_provider.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/image_strings.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/helpers/helper_functions.dart';


class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dark = THelperFunctions.isDarkMode(context);

     final cartData = ref.watch(cartProvider);
    
    final totalAmount = ref.read(cartProvider.notifier).calculateTotaLAmount();

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text("Checkout", style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.black),),
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
          children: [
            // Items in Cart
              TCarItems(showAddRemoveButtons: false,),
              const SizedBox(height: TSizes.spaceBtwSections,),

              // Coupon Textfield
              TCouponCode(),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Billing Sections
              TRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: dark ? TColors.black : TColors.white,
                   child: Column(
                  children: [
                    // Pricing
                    TBillingAmountSection(),
                    const SizedBox(height: TSizes.spaceBtwItems,),

                    const Divider(),
                    const SizedBox(height: TSizes.spaceBtwItems,),

                    //Payment Methode
                    TBillingPaymentSection(),
                    const SizedBox(height: TSizes.spaceBtwItems,),

                    //Address Section
                    TBillingAddressSection(),
                    const SizedBox(height: TSizes.spaceBtwItems,),


                  ], 
                )
                ),
             

          ],
          )

          ),
      ),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: ElevatedButton(onPressed: () => Get.to(() => 
             SuccessScreen(
              image: TImages.successfulPaymentIcon,
              title: 'Payment Success',
              subTitle: 'Your item will be shipped soon!',
              onPressed: () => Get.offAll(() =>  MainScreen()),
              )), child: Text('Checkout \$$totalAmount'),),
          ),
    );
  }
}
