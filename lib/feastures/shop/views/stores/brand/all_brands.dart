import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
import 'package:tm_store_app/common/widgets/brands/brand_card.dart';
import 'package:tm_store_app/common/widgets/layouts/grid_layout.dart';
import 'package:tm_store_app/common/widgets/texts/section_heading.dart';
import 'package:tm_store_app/feastures/shop/views/stores/brand/brand_product.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/helpers/helper_functions.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      // appBar: TAppBar(title: Text('All Brands', style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.white),), showBackArrow: true),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight), // Standard AppBar height
        child: Container(
          color: TColors.primary, // <-- Your desired background color
          child: TAppBar(showBackArrow: true, title: Text('All Brands', style: Theme.of(context).textTheme.headlineMedium!.apply(color: dark ? TColors.dark : TColors.light))),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Heading
              TSectionHeading(title: 'Brand', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Brands
              TGridLayout(itemCount: 10, mainAxisExtent: 80, itemBuilder: (context, index) => TBrandCard(showBorder: true, onTap: () => Get.to(() => BrandProduct()))),
            ],
          ),
        ),
      ),
    );
  }
}
