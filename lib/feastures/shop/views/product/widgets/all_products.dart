import 'package:flutter/material.dart';
import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
import 'package:tm_store_app/common/widgets/products/sortable/sortable_product.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/helpers/helper_functions.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight), // Standard AppBar height
        child: Container(
          color: dark ? Colors.grey[900] : TColors.primary, // <-- Your desired background color
          child: TAppBar(title: Text('All Products', style: Theme.of(context).textTheme.headlineMedium!.apply(color: dark ? TColors.dark : TColors.light)), showBackArrow: true),
        ),
      ),
      body: SingleChildScrollView(child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace), child: TSortableProduct())),
    );
  }
}
