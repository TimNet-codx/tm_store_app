import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tm_store_app/provider/user_provider.dart';
import 'package:tm_store_app/service/global_variables.dart';
import 'package:tm_store_app/utils/constants/image_strings.dart';
import 'package:tm_store_app/utils/helpers/network_manager.dart';
import 'package:tm_store_app/utils/popups/full_screen_loader.dart';
import 'package:tm_store_app/utils/popups/loaders.dart';
import 'package:tm_store_app/main_screen.dart';

final providerContainer = ProviderContainer();

class LoginUserController extends GetxController {
  static LoginUserController get instance => Get.find();

         // Variables
   final rememberMe = false.obs;
   final hidePassword = true.obs;
  //  final localStorage = GetStorage();
   final  email = TextEditingController();
   final password = TextEditingController();
   GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
Future<void> signInUser({ required BuildContext context, required String email, required String password,}) async {
  try {
    /// 🔄 START LOADING
    TFullScreenLoader.openLoadingDialog('Logging you in...',TImages.docerAnimation);

    /// 🌐 CHECK INTERNET
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      throw 'No internet connection';
    }

    /// 📡 API CALL
    final response = await http.post(Uri.parse('$uri/api/signin'),
      headers: const {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'email': email.trim(), 'password': password.trim(),
      }),
    );

    /// ❌ HANDLE SERVER ERRORS
if (response.statusCode != 200 && response.statusCode != 201) {
  String errorMessage = 'Login failed';

  try {
    final decoded = jsonDecode(response.body);
    if (decoded is Map) {
      errorMessage = decoded['message'] ?? decoded['msg'] ?? errorMessage;
    }
  } catch (_) {}

  throw Exception(errorMessage);
}

    /// ✅ SUCCESS RESPONSE
    final decoded = jsonDecode(response.body);

    final token = decoded['token'];
    final userJson = jsonEncode(decoded['user']);

    /// 💾 SAVE TO LOCAL STORAGE
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth-token', token);
    await prefs.setString('user', userJson);

    /// 🧠 UPDATE APP STATE
    providerContainer
        .read(userProvider.notifier)
        .setUser(userJson);

    /// 🛑 STOP LOADER
    TFullScreenLoader.stopLoading();

    /// 🚀 NAVIGATION
   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>  MainScreen()), (route)=> false);


    /// 🎉 SUCCESS MESSAGE
    TLoaders.successSnackBar(title: 'Success', message: 'Login successful');
  } catch (e) {
    /// 🛑 STOP LOADER SAFELY
    TFullScreenLoader.stopLoading();

    /// ❗ SHOW ERROR
    TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString().replaceAll('Exception:', '').trim() );
  }
}
}