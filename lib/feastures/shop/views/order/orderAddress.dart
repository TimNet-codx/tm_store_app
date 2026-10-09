import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_store_app/common/widgets/texts/section_heading.dart';
import 'package:tm_store_app/feastures/shop/controllers/order_controller.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';

class TOrderAddressSection extends StatelessWidget {
  const TOrderAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderController controller = Get.put(OrderController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          child: TSectionHeading(
            title: "Order Address",
            buttonTitle: 'Change',
            onPerssed: () => _showSelectAddress(context),
          ),
        ),
        Text("T's Store", style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        Row(
          children: [
            const Icon(Icons.phone, color: Colors.grey, size: 16),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text(
              '+5768934678787236',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        Row(
          children: [
            const Icon(Icons.location_history, color: Colors.grey, size: 16),
            const SizedBox(width: TSizes.spaceBtwItems),
            Expanded(
              child: Text(
                'South Liana, Kwara, 32467 USA',
                style: Theme.of(context).textTheme.bodyMedium,
                softWrap: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

void _showSelectAddress(BuildContext context) {
  // showModalBottomSheet(
  //   context: context,
  //   isScrollControlled: true,
  //   backgroundColor: Colors.transparent,
  //   builder: (context) => const SelectOrderAddress(),
  // );
}
