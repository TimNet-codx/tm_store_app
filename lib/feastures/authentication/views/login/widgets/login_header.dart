import  'package:flutter/material.dart';
import 'package:tm_store_app/utils/constants/image_strings.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/constants/text_strings.dart';



class TSignInHeader extends StatelessWidget {
  const TSignInHeader({
    super.key});

  @override
  Widget build(BuildContext context) {
   // final dark = THelperFunctions.isDarkMode(context);
    return Center(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            height: 150 ,
            image: AssetImage(TImages.authImage),),
            Text(TTexts.loginTitle, style: Theme.of(context).textTheme.headlineMedium,),
            const SizedBox(height: TSizes.sm,),
            Text(TTexts.loginSubTitle, style: Theme.of(context).textTheme.bodyMedium)
        ],
      ),
    );
  }
}