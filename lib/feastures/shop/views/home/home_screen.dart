import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_store_app/common/widgets/custom_shape/container/primary_header_container.dart';
import 'package:tm_store_app/common/widgets/custom_shape/container/search_container.dart';
import 'package:tm_store_app/common/widgets/layouts/grid_layout.dart';
import 'package:tm_store_app/common/widgets/products/product_card/product_card_vertical.dart';
import 'package:tm_store_app/common/widgets/texts/section_heading.dart';
import 'package:tm_store_app/feastures/shop/controllers/product_controller.dart';
import 'package:tm_store_app/feastures/shop/views/home/widgets/banner_widget.dart';
import 'package:tm_store_app/feastures/shop/views/home/widgets/home_appbar.dart';
import 'package:tm_store_app/feastures/shop/views/home/widgets/home_categories.dart';
import 'package:tm_store_app/feastures/shop/views/product/widgets/all_products.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
     final ProductController productController = Get.put(ProductController());


    return Scaffold(
       body: SingleChildScrollView(
        child: Column(
          children: [
              // Header
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  // Appbar
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: THomeAppBar(),
                  ),
                  SizedBox(height: TSizes.spaceBtwSections),
                  // Searchbar
                  TSearchContainer(text: 'Search in Store'),
                  SizedBox(height: TSizes.spaceBtwSections),
                  // Categories
                Padding(
                    padding: const EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        // Categories Header
                        TSectionHeading(title: 'Popular Categories', showActionButton: false,),
                        SizedBox(height: TSizes.spaceBtwItems),
                        // Categories List
                        THomeCategories(),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections,),
                ],
              )
            ),
            BannerWidget(),
            // const SizedBox(height: TSizes.spaceBtwSections),

        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                 TSectionHeading(title: 'Popular Products', onPerssed: () => Get.to(() => const AllProducts())),
                 const SizedBox(height: TSizes.spaceBtwItems),

                 // Popular Products
            Obx(() {
            // 1. Check the correct loading variable
            if (productController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
            }

            // 2. Check the correct list
            if (productController.popularProducts.isEmpty) {
            return const Column(
            children: [
              Icon(Icons.inventory_2_outlined, size: 50, color: Colors.grey),
              SizedBox(height: 10),
              Text("No Popular Products Found"),
            ],
            );
            } else {
              print("Products Loaded: ${productController.popularProducts.length}");
            }

            // 3. Render the grid
            return TGridLayout(
            itemCount: productController.popularProducts.length,
            itemBuilder: (_, index) => TProductCardVertical(
            product: productController.popularProducts[index],
            ),
            );
            })
                ]
                )
             )
             // Heading

          ],
        ) ,),
    );
  }
}