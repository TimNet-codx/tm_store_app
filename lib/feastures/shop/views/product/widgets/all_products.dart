import 'package:flutter/material.dart';
import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
import 'package:tm_store_app/common/widgets/products/sortable/sortable_product.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';


class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: Text('All Products',  style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.white),), showBackArrow: true),
      body: SingleChildScrollView(child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace), child: TSortableProduct())),
    );
  }
}
