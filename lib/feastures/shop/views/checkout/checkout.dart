import 'package:flutter/material.dart';
import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
import 'package:tm_store_app/common/widgets/custom_shape/container/rounded_container.dart';
import 'package:tm_store_app/common/widgets/products/cart/coupon_widget.dart';
import 'package:tm_store_app/feastures/shop/views/cart/widgets/cart_items.dart';
import 'package:tm_store_app/feastures/shop/views/checkout/widgets/billing_address_section.dart';
import 'package:tm_store_app/feastures/shop/views/checkout/widgets/billing_amount_section.dart';
import 'package:tm_store_app/feastures/shop/views/checkout/widgets/billing_payment_section.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/helpers/helper_functions.dart';


class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text("Checkout", style: Theme.of(context).textTheme.headlineSmall),
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
        // bottomNavigationBar: Padding(
        //     padding: const EdgeInsets.all(TSizes.defaultSpace),
        //     child: ElevatedButton(onPressed: () => Get.to(() => 
        //      SuccessScreen(
        //       image: TImages.successfulPaymentIcon,
        //       title: 'Payment Success',
        //       subTitle: 'Your item will be shipped soon!',
        //       onPressed: () => Get.offAll(() => const NavigationMenu()),
        //       )), child: Text('Checkout \$245')),
        //   ),
    );
  }
}
