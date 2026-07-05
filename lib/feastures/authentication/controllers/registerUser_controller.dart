import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tm_store_app/common/widgets/success_screen/success_screen.dart';
import 'package:tm_store_app/feastures/authentication/models/user.dart';
import 'package:tm_store_app/feastures/authentication/views/login/login.dart';
import 'package:tm_store_app/service/global_variables.dart';
import 'package:tm_store_app/utils/constants/image_strings.dart';
import 'package:tm_store_app/utils/constants/text_strings.dart';
import 'package:tm_store_app/utils/helpers/network_manager.dart';
import 'package:tm_store_app/utils/popups/full_screen_loader.dart';
import 'package:tm_store_app/utils/popups/loaders.dart';

final providerContainer = ProviderContainer();

class RegisterUserController extends GetxController {
  static RegisterUserController get instance => Get.find();

  // Variables
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final fullName = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  final phoneNumber = TextEditingController();

  // GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  Future<void> signUpUser({required BuildContext context, required String fullName, required String email, required String password, required String street, required String city, required String postalCode, required String phoneNumber, required String state, required String country}) async {
    try {
      TLoaders.openLoadingDialog('We are processing your information...', TImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.stopLoading();
        return;
      }

      final user = UserModel(id: '', fullName: fullName.trim(), email: email.trim(), postalCode: postalCode.trim(), state: state.trim(), city: city.trim(), street: street.trim(), password: password.trim(), phoneNumber: phoneNumber.trim(), token: '', country: country.trim());

      final response = await http.post(Uri.parse('$uri/api/signup'), headers: const {'Content-Type': 'application/json; charset=UTF-8'}, body: user.toJson());

      if (response.statusCode != 200 && response.statusCode != 201) {
        TLoaders.stopLoading();
        final message = jsonDecode(response.body)['message'] ?? 'Signup failed';
        throw message;
      }

      /// 🛑 STOP LOADER
      TLoaders.stopLoading();

      /// 🎉 SUCCESS MESSAGE
      TLoaders.successSnackBar(title: 'Congratulations', message: 'User account created successfully. Please login to continue.');

      /// 🚀 REDIRECT TO LOGIN
      //  Navigator.push(context, MaterialPageRoute(builder: (context) =>  LogInScreen()));
      Get.off(() => SuccessScreen(image: TImages.successfullyRegisterAnimation, title: TTexts.yourAccountCreatedTitle, subTitle: TTexts.yourAccountCreatedSubTitle, onPressed: () => Get.offAll(() => const LogInScreen())));
    } catch (e) {
      TLoaders.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
