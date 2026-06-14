import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
import 'package:tm_store_app/common/widgets/layouts/grid_layout.dart';
import 'package:tm_store_app/common/widgets/products/product_card/product_card_vertical.dart';
import 'package:tm_store_app/feastures/shop/controllers/product_controller.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());
    
    return Scaffold(
      appBar: TAppBar(title: Text('Favorite', style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.black),)),
      body: SingleChildScrollView(child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace), child: Column( children: [TGridLayout(itemCount: productController.favouriteProducts.length, itemBuilder: (_, index) =>  TProductCardVertical(product: productController.favouriteProducts[index],))],),)),
    );
  }
}
