import 'package:flutter/material.dart';
import 'package:tm_store_app/common/widgets/brands/brand_card.dart';
import 'package:tm_store_app/common/widgets/custom_shape/container/rounded_container.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/helpers/helper_functions.dart';


class TBrandShowcase extends StatelessWidget {
  const TBrandShowcase({super.key, required this.images,});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
 
    return TRoundedContainer(
      showBorder: true,
      borderColor: TColors.darkGrey,
      backgroundColor: Colors.transparent,
      padding: const EdgeInsets.all(TSizes.md),
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
      child: Column(
        children: [
          // Brand with of the Prodcuts
          TBrandCard(showBorder: false,),
    
          // Brand Tap 3 Products image
          Row(
            // children: [
            //   Expanded(
            //     child: TRoundedContainer(
            //       height: 100,
            //       backgroundColor: dark ? TColors.darkGrey: TColors.light,
            //       margin: const EdgeInsets.only(right: TSizes.sm),
            //       padding: const EdgeInsets.all(TSizes.md),
            //       child:  const Image(fit: BoxFit.contain, image: AssetImage(TImages.productImage3),),
            //       )
            //     ),
            //   Expanded(
            //     child: TRoundedContainer(
            //       height: 100,
            //       backgroundColor: dark ? TColors.darkGrey: TColors.light,
            //       margin: const EdgeInsets.only(right: TSizes.sm),
            //       padding: const EdgeInsets.all(TSizes.md),
            //       child:  const Image(fit: BoxFit.contain, image: AssetImage(TImages.productImage3),),
            //       )
            //     ),
            //   Expanded(
            //     child: TRoundedContainer(
            //       height: 100,
            //       backgroundColor: dark ? TColors.darkGrey: TColors.light,
            //       margin: const EdgeInsets.only(right: TSizes.sm),
            //       padding: const EdgeInsets.all(TSizes.md),
            //       child:  const Image(fit: BoxFit.contain, image: AssetImage(TImages.productImage3),),
            //       )
            //     ),
            // ],
            children: images.map((image) => brandTopProductImageWidget(image,context)).toList(),
          )
    
      ],),
    );
  }
}

Widget brandTopProductImageWidget(String image, context){
     final dark = THelperFunctions.isDarkMode(context);
   return Expanded(
          child: TRoundedContainer(
            height: 100,
            backgroundColor: dark ? TColors.darkGrey: TColors.light,
            margin: const EdgeInsets.only(right: TSizes.sm),
            padding: const EdgeInsets.all(TSizes.md),
            child:   Image(fit: BoxFit.contain, image: AssetImage(image),),
            )
        );
}



