import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tm_store_app/feastures/authentication/views/login/login.dart';
import 'package:tm_store_app/provider/user_provider.dart';
import 'package:tm_store_app/utils/constants/image_strings.dart';
import 'package:tm_store_app/utils/popups/full_screen_loader.dart';
import 'package:tm_store_app/utils/popups/loaders.dart';


final providerContainer = ProviderContainer();

class SignOutUserController extends GetxController{
    static SignOutUserController get instance => Get.find();

    // SignOut Users Function
  Future<void> signOutUser({required context}) async{
    try {
          /// 🔄 START LOADING
    TFullScreenLoader.openLoadingDialog('Logging you out...',TImages.docerAnimation);
      // Access SharedPreferences for token and User Date Storage
      SharedPreferences preferences = await SharedPreferences.getInstance();
      // Remove the authentication token from SharedPreferences
      await preferences.remove('auth-token');
      // Remove the user data from SharedPreferences
      await preferences.remove('user');

      // Clear the user state in the app using Riverpod
      providerContainer.read(userProvider.notifier).signOut();
      TFullScreenLoader.stopLoading();

        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LogInScreen()), (route)=> false);

      //showSnackBar(context, 'SignOut Successful'); 
    TLoaders.successSnackBar(title: 'Success', message: 'SignOut successful');

    } catch (e) {
      print("Error: $e"); 
    }
    
  }
}