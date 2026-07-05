import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_store_app/common/widgets/custom_shape/container/rounded_container.dart';
import 'package:tm_store_app/common/widgets/texts/section_heading.dart';
import 'package:tm_store_app/feastures/shop/controllers/checkout_controller.dart';
import 'package:tm_store_app/feastures/shop/views/checkout/widgets/paymetMethodSelect.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/helpers/helper_functions.dart';

class TBillingPaymentSection extends StatelessWidget {
  const TBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    final controller = Get.put(CheckoutController());
    return Column(
      children: [
        GestureDetector(
          //onTap: () => _showSelectPaymentMethod(context),
          child: TSectionHeading(title: "Payment Method", buttonTitle: 'Change', onPerssed: () => _showSelectPaymentMethod(context)),
        ),
        //  TSectionHeading(title: "Payment Method", buttonTitle: 'Change', onPerssed: () {},),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        Obx(() {
          final currentMethod = controller.selectedPaymentMethod.value;

          return Row(children: [TRoundedContainer(width: 60, height: 35, backgroundColor: dark ? TColors.dark : TColors.light, padding: const EdgeInsets.all(TSizes.sm), child: Image(image: AssetImage(currentMethod.image), fit: BoxFit.contain)), const SizedBox(width: TSizes.spaceBtwItems / 2), Text(currentMethod.name, style: Theme.of(context).textTheme.bodyLarge)]);
        }),
      ],
    );
  }
}

void _showSelectPaymentMethod(BuildContext context) {
  showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (context) => const Paymetmethodselect());
}
