import 'package:flutter/material.dart';
import 'package:tm_store_app/common/widgets/texts/section_heading.dart';
import 'package:tm_store_app/feastures/shop/views/checkout/widgets/seletectAddress.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';

class TBillingAddressSection extends StatelessWidget {
  const TBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(child: TSectionHeading(title: "Shipping  Address", buttonTitle: 'Change', onPerssed: () => _showSelectAddress(context))),
        Text("T's Store", style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        Row(children: [const Icon(Icons.phone, color: Colors.grey, size: 16), const SizedBox(width: TSizes.spaceBtwItems), Text('+34678787236', style: Theme.of(context).textTheme.bodyMedium)]),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        Row(children: [const Icon(Icons.location_history, color: Colors.grey, size: 16), const SizedBox(width: TSizes.spaceBtwItems), Expanded(child: Text('South Liana, Kwara, 32467 USA', style: Theme.of(context).textTheme.bodyMedium, softWrap: true))]),
      ],
    );
  }
}

void _showSelectAddress(BuildContext context) {
  showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (context) => const SelectAddress());
}
