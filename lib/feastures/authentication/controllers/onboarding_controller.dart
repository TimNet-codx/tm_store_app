import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tm_store_app/feastures/authentication/views/login/login.dart';


class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();
  // Variable
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  // Update Current index when Page Scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;

   // jump to the specific dot selected page
   void dotNavigationClick(index){
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
    pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.ease);
   }

   // Update Curret Index & jump to the next page
  //  void nextPage(){
  //   if(currentPageIndex.value == 2){
  //     final storage = Get.find<SharedPreferences>();
  //       storage.write('IsFirstTime', false);
  //       Get.to(LogInScreen());
  //   }else{
  //     int page = currentPageIndex.value + 1;
  //      pageController.jumpToPage(page);
  //   }
  //  }

Future<void> nextPage() async {
  if (currentPageIndex.value == 2) {
    final storage = Get.find<SharedPreferences>();
    
    // 2. Use setBool with await instead of .write()
    await storage.setBool('IsFirstTime', false);
    
    // 3. Use Get.off() instead of Get.to() so they can't click "back" to onboarding
    Get.off(() => const LogInScreen());
  } else {
    int page = currentPageIndex.value + 1;
    pageController.jumpToPage(page);
  }
}

// void nextPage() {
//   if (currentPageIndex.value == 2) {
//     // 1. Change the type definition to GetStorage
//     final storage = Get.find<GetStorage>();
    
//     // 2. This syntax works perfectly now
//     storage.write('IsFirstTime', false);
    
//     // 3. Prevent going back to onboarding via back button
//     Get.off(() => const LogInScreen());
//   } else {
//     int page = currentPageIndex.value + 1;
//     pageController.jumpToPage(page);
//   }
// }

// Update Current Index & jump to the last page
   void skipPage(){
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
    Get.to(LogInScreen());
   }

  //final pageController = PageController();

  // void nextPage() {
  //   pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
  // }

  // void dotNavigationClick(int index) {
  //   pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.ease);
  // }
}