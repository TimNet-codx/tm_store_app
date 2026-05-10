import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
import 'package:tm_store_app/common/widgets/brands/brand_card.dart';
import 'package:tm_store_app/common/widgets/layouts/grid_layout.dart';
import 'package:tm_store_app/common/widgets/texts/section_heading.dart';
import 'package:tm_store_app/feastures/shop/views/stores/brand/brand_product.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: Text('Brand'), showBackArrow: true),
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
