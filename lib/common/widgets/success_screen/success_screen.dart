// import 'package:flutter/material.dart';
// import 'package:tim_store/common/styles/spacing_styles.dart';
// import 'package:tim_store/utils/constants/sizes.dart';
// import 'package:tim_store/utils/constants/text_strings.dart';
// import 'package:tim_store/utils/helpers/helper_functions.dart';


// //  Later change to reuseable succes screen widget
// class SuccessScreen extends StatelessWidget {
//   const SuccessScreen({super.key, required this.image, required this.title, required this.subTitle, required this.onPressed });

//   final String image, title, subTitle;
//   final VoidCallback onPressed;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: TSpacingStyles.paddingWithAppBarHeight * 2,
//           child: Column(
//             children: [
//                // Image
//               Image(
//                 image:  AssetImage(image),
//                 width: THelperFunctions.screenWidth() * 0.6,
//                 ),
//                 const SizedBox(height: TSizes.spaceBtwSections), 
              
//               // Title &  Subtitle
//               // Text(TTexts.yourAccountCreatedTitle, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
//               // const SizedBox(height: TSizes.spaceBtwItems),
//               // Text(TTexts.yourAccountCreatedSubTitle, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center,),
//               // const SizedBox(height: TSizes.spaceBtwSections), 
//                Text(title, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
//               const SizedBox(height: TSizes.spaceBtwItems),
//               Text(subTitle, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center,),
//               const SizedBox(height: TSizes.spaceBtwSections), 
             
//               // Buttons
//             // SizedBox(
//             //   width: double.infinity,
//             //   height: 50,
//             //     child: ElevatedButton(
//             //       onPressed: () => Get.to(() => const LoginScreen()),
//             //       style: ElevatedButton.styleFrom(
//             //               shape: RoundedRectangleBorder(
//             //                 borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
//             //               ),
//             //             ),
//             //       child: const Text(TTexts.tContinue),
//             //  ),
//             // ),
//                SizedBox(
//               width: double.infinity,
//               height: 50,
//                 child: ElevatedButton(
//                   onPressed: onPressed,
//                   style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
//                           ),
//                         ),
//                   child: const Text(TTexts.tContinue),
//              ),
//             ),
//           ],),
//           ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/constants/text_strings.dart';
import 'package:tm_store_app/utils/helpers/helper_functions.dart';
import 'package:tm_store_app/utils/styles/spacing_styles.dart';


class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.onPressed,
  });

  final String image, title, subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final bool isLottie = image.toLowerCase().endsWith('.json');

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyles.paddingWithAppBarHeight * 2,
          child: Column(
            children: [
              // Image or Animation
              isLottie
                  ? Lottie.asset(
                      image,
                      width: THelperFunctions.screenWidth() * 0.6,
                    )
                  : Image.asset(
                      image,
                      width: THelperFunctions.screenWidth() * 0.6,
                    ),
              const SizedBox(height: TSizes.spaceBtwSections),
              // Title & Subtitle
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                subTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                    ),
                  ),
                  child: const Text(TTexts.tContinue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
