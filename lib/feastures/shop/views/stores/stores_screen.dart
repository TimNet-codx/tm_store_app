import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
import 'package:tm_store_app/common/widgets/appbar/tabbar.dart';
import 'package:tm_store_app/common/widgets/brands/brand_card.dart';
import 'package:tm_store_app/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:tm_store_app/common/widgets/custom_shape/container/search_container.dart';
import 'package:tm_store_app/common/widgets/layouts/grid_layout.dart';
import 'package:tm_store_app/common/widgets/texts/section_heading.dart';
import 'package:tm_store_app/feastures/shop/views/cart/cart_screen.dart';
import 'package:tm_store_app/feastures/shop/views/stores/brand/all_brands.dart';
import 'package:tm_store_app/feastures/shop/views/stores/widgets/category_tab.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/helpers/helper_functions.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        //appBar: TAppBar(title: Text('Store', style: Theme.of(context).textTheme.headlineMedium!.apply(color: dark ? Colors.white : Colors.black)), actions: [TCartCounterIcon(onPressed: () => Get.to(() => const CartScreen()), iconColor: dark ? TColors.light : TColors.dark)]),
        appBar: PreferredSize(
          //preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.08), // Standard AppBar height
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            color: TColors.primary, // <-- Your desired background color
            child: TAppBar(showBackArrow: false, title: Text('Store', style: Theme.of(context).textTheme.headlineMedium!.apply(color: dark ? TColors.dark : TColors.white)), actions: [TCartCounterIcon(onPressed: () => Get.to(() => const CartScreen()), iconColor: dark ? TColors.dark : TColors.white)]),
          ),
        ),

        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: dark ? TColors.black : TColors.white,
                expandedHeight: 440,

                flexibleSpace: Padding(
                  padding: EdgeInsets.all(TSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      // Search Bar
                      const SizedBox(height: TSizes.spaceBtwItems),
                      TSearchContainer(text: "Search in Store", showBorder: true, showBackground: false, padding: EdgeInsets.zero),
                      const SizedBox(height: TSizes.spaceBtwSections),
                      // Featured Brands
                      TSectionHeading(title: 'Featured Brands', onPerssed: () => Get.to(() => const AllBrandsScreen())),
                      const SizedBox(height: TSizes.spaceBtwItems / 1.0),

                      TGridLayout(
                        itemCount: 4,
                        mainAxisExtent: 80,
                        itemBuilder: (_, index) {
                          return const TBrandCard();
                        },
                      ),
                    ],
                  ),
                ),

                // Tab
                bottom: const TTabBar(tabs: [Tab(child: Text('Sports')), Tab(child: Text('Furniture')), Tab(child: Text('Electronics')), Tab(child: Text('Cloths')), Tab(child: Text('Cosmetics'))]),
              ),
            ];
          },
          body: TabBarView(children: [TCategoryTab(), TCategoryTab(), TCategoryTab(), TCategoryTab(), TCategoryTab()]),
        ),
      ),
    );
  }
}
