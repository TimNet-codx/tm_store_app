import 'package:flutter/material.dart';
import 'package:tm_store_app/common/widgets/custom_shape/container/primary_header_container.dart';
import 'package:tm_store_app/common/widgets/custom_shape/container/search_container.dart';
import 'package:tm_store_app/common/widgets/texts/section_heading.dart';
import 'package:tm_store_app/feastures/shop/views/home/widgets/banner_widget.dart';
import 'package:tm_store_app/feastures/shop/views/home/widgets/home_appbar.dart';
import 'package:tm_store_app/feastures/shop/views/home/widgets/home_categories.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                        TSectionHeading(title: 'Popular Categories', showActionButton: false),
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
            BannerWidget()
          ],
        ) ,),
    );
  }
}