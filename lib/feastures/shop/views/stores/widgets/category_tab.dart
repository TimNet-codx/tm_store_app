import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_store_app/common/widgets/brands/brand_show_case.dart';
import 'package:tm_store_app/common/widgets/layouts/grid_layout.dart';
import 'package:tm_store_app/common/widgets/products/product_card/product_card_vertical.dart';
import 'package:tm_store_app/common/widgets/texts/section_heading.dart';
import 'package:tm_store_app/feastures/shop/controllers/product_controller.dart';
import 'package:tm_store_app/utils/constants/image_strings.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
         final ProductController productController = Get.put(ProductController());
         
    return   ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
          Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    // Brands
                    TBrandShowcase(images: [TImages.authImage, TImages.darkAppLogo, TImages.authImage],),
                    const SizedBox(height: TSizes.spaceBtwItems,),
                    // Products
                    TSectionHeading(title: 'You might like', onPerssed: () {},),
                    const SizedBox(height: TSizes.spaceBtwItems,),
      
                    TGridLayout(itemCount: productController.popularProducts.length, itemBuilder: (_, index) => TProductCardVertical(product: productController.popularProducts[index],)),
                    const SizedBox(height: TSizes.spaceBtwSections,),

                  ],
                ),
      ),
      ],
      
    
    );
  }
}