import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tm_store_app/feastures/authentication/models/user.dart';
import 'package:tm_store_app/feastures/authentication/views/login/login.dart';
import 'package:tm_store_app/service/global_variables.dart';
import 'package:tm_store_app/utils/constants/image_strings.dart';
import 'package:tm_store_app/utils/helpers/network_manager.dart';
import 'package:tm_store_app/utils/popups/full_screen_loader.dart';
import 'package:tm_store_app/utils/popups/loaders.dart';


final providerContainer = ProviderContainer();

class RegisterUserController extends GetxController{
    static RegisterUserController get instance => Get.find();
    // Variables
  final hidePassword = true.obs;
  // final hideConfirmPassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final fullName = TextEditingController();
  final password = TextEditingController();
  // final username = TextEditingController();
  // final confirmPassword = TextEditingController();
  //final firstName = TextEditingController();
  //final phoneNumber = TextEditingController();
  //final gender = ''.obs; // Example: 'Male', 'Female', 'Other'
  //final dob = TextEditingController();
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  Future<void> signUpUser({required BuildContext context,required String fullName, required String email, required String password}) async {
      try {
        /// 🔄 START LOADING
        TFullScreenLoader.openLoadingDialog(
          'We are processing your information...',
          TImages.docerAnimation,
        );

        /// 🌐 CHECK INTERNET CONNECTION
        final isConnected = await NetworkManager.instance.isConnected();
        if (!isConnected) {
          TFullScreenLoader.stopLoading();
          return;
        }

        /// 🧾 CREATE User MODEL
        final user = UserModel(
          id: '',
          fullName: fullName.trim(),
          email: email.trim(),
          state: '',
          city: '',
          locality: '',
          password: password.trim(),
          token: ''
        );

        /// 📡 API CALL
        final response = await http.post( Uri.parse('$uri/api/signup'),
          headers: const {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: user.toJson(),
        );

        /// ❌ HANDLE API ERRORS
        if (response.statusCode != 200 && response.statusCode != 201) {
          TFullScreenLoader.stopLoading();
          final message = jsonDecode(response.body)['message'] ?? 'Signup failed';
          throw message;
        }

        /// 🛑 STOP LOADER
        TFullScreenLoader.stopLoading();

        /// 🎉 SUCCESS MESSAGE
        TLoaders.successSnackBar(title: 'Congratulations', message: 'User account created successfully. Please login to continue.',);

        /// 🚀 REDIRECT TO LOGIN
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  LogInScreen()));

        
        /// 🎉 SUCCESS MESSAGE
        TLoaders.successSnackBar(title: 'Congratulations', message: 'User account created successfully. Please login to continue.',);
      } catch (e) {
        /// 🛑 STOP LOADER ON ERROR
        TFullScreenLoader.stopLoading();

        /// ❗ ERROR MESSAGE
        TLoaders.errorSnackBar(
          title: 'Oh Snap!',
          message: e.toString(),
        );
      }
}


}