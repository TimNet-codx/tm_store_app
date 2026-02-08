import 'package:flutter/material.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/image_strings.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';


class TSocialButtons extends StatelessWidget {
  const TSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(SignInController());
    return Row(
     mainAxisAlignment: MainAxisAlignment.center,
     children: [
       Container(
         decoration: BoxDecoration(
           border: Border.all(color: TColors.grey), borderRadius: BorderRadius.circular(100)),
           child: IconButton(onPressed: () {}, icon: const Image(image: AssetImage(TImages.google), width: TSizes.iconMd, height: TSizes.iconMd,)),
       ),
       const SizedBox(width: TSizes.spaceBtwItems,),
         Container(
         decoration: BoxDecoration(
           border: Border.all(color: TColors.grey), borderRadius: BorderRadius.circular(100)),
           child: IconButton(onPressed: () {}, icon: const Image(image: AssetImage(TImages.facebook), width: TSizes.iconMd, height: TSizes.iconMd,)),
       )
    ],
    );
  }
}