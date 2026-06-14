import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_store_app/feastures/authentication/controllers/onboarding_controller.dart';
import 'package:tm_store_app/feastures/authentication/views/onboarding/widget/onboarding_dotnavigation.dart';
import 'package:tm_store_app/feastures/authentication/views/onboarding/widget/onboarding_nextbutton.dart';
import 'package:tm_store_app/feastures/authentication/views/onboarding/widget/onboarding_page.dart';
import 'package:tm_store_app/feastures/authentication/views/onboarding/widget/onboarding_skip.dart';
import 'package:tm_store_app/utils/constants/image_strings.dart';
import 'package:tm_store_app/utils/constants/text_strings.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
   final controller = Get.put(OnboardingController());
    return Scaffold(
        body: Stack(
         children: [
            PageView(
                controller: controller.pageController,
                onPageChanged: controller.updatePageIndicator,
                children: [
                       OnBoardingPage(image: TImages.onBoardingImage1, title: TTexts.onBoardingTitle1, subTitle: TTexts.onBoardingSubTitle1,),
                       OnBoardingPage(image: TImages.onBoardingImage2, title: TTexts.onBoardingTitle2, subTitle: TTexts.onBoardingSubTitle2,),
                       OnBoardingPage(image: TImages.onBoardingImage3, title: TTexts.onBoardingTitle3, subTitle: TTexts.onBoardingSubTitle3,),
                ],
            ),

          // Skip Button 
          OnBoardingSkip(),
          
          // Dot Navigation
          OnBoardingDotNavigation(),

          //Circular Button
          OnBoardingNextButton()

         ]
        )
    );
  }
}