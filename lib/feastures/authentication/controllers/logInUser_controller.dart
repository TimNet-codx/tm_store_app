import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tm_store_app/feastures/authentication/controllers/user_controller.dart';
import 'package:tm_store_app/provider/cart_provider.dart';
import 'package:tm_store_app/provider/user_provider.dart';
import 'package:tm_store_app/service/global_variables.dart';
import 'package:tm_store_app/utils/constants/image_strings.dart';
import 'package:tm_store_app/utils/helpers/network_manager.dart';
import 'package:tm_store_app/utils/popups/loaders.dart';
import 'package:tm_store_app/main_screen.dart';

final providerContainer = ProviderContainer();

class LoginUserController extends GetxController {
  static LoginUserController get instance => Get.find();

  // Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  //  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();

  //  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  // Future<void> signInUser({
  //   required BuildContext context,
  //   required String email,
  //   required String password,
  // }) async {
  //   try {
  //     /// 🔄 START LOADING
  //     TLoaders.openLoadingDialog('Logging you in...', TImages.docerAnimation);

  //     /// 🌐 CHECK INTERNET
  //     final isConnected = await NetworkManager.instance.isConnected();
  //     if (!isConnected) {
  //       throw 'No internet connection';
  //     }

  //     /// 📡 API CALL
  //     final response = await http.post(
  //       Uri.parse('$uri/api/signin'),
  //       headers: const {'Content-Type': 'application/json; charset=UTF-8'},
  //       body: jsonEncode({'email': email.trim(), 'password': password.trim()}),
  //     );

  //     /// ❌ HANDLE SERVER ERRORS
  //     if (response.statusCode != 200 && response.statusCode != 201) {
  //       String errorMessage = 'Login failed';

  //       try {
  //         final decoded = jsonDecode(response.body);
  //         if (decoded is Map) {
  //           errorMessage = decoded['message'] ?? decoded['msg'] ?? errorMessage;
  //         }
  //       } catch (_) {}

  //       throw Exception(errorMessage);
  //     }

  //     /// ✅ SUCCESS RESPONSE
  //     final decoded = jsonDecode(response.body);

  //     final String token = decoded['token'];
  //     // final userJson = jsonEncode(decoded['user']);
  //     final userMap = decoded['user'];
  //     final userJson = jsonEncode(userMap);

  //     /// 💾 SAVE TO LOCAL STORAGE
  //     final prefs = await SharedPreferences.getInstance();
  //     // await prefs.setString('auth-token', token);
  //     await prefs.setString('token', token);
  //     await prefs.setString('user', userJson);

  //     /// 🧠 UPDATE APP STATE
  //     // providerContainer
  //     //     .read(userProvider.notifier)
  //     //     .setUser(userJson);

  //     /// 🧠 ACCESS THE ACTIVE RIVERPOD CONTAINER FROM CONTEXT
  //     // This links directly to the ProviderScope at the root of your application
  //     final container = ProviderScope.containerOf(context);

  //     // 1. Set the active user globally in Riverpod
  //     container.read(userProvider.notifier).setUser(userJson);

  //     // 2. ✅ EXTRACT MONGODB USER ID AND FETCH CART IMMEDIATELY ON LOGIN
  //     final String userId = userMap['id'] ?? userMap['_id'] ?? '';
  //     if (userId.isNotEmpty) {
  //       await container.read(cartProvider.notifier).loadUserCart(userId);
  //     }

  //     /// 🛑 STOP LOADER
  //     TLoaders.stopLoading();

  //     /// 🚀 NAVIGATION
  //     Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(builder: (context) => MainScreen()),
  //       (route) => false,
  //     );

  //     /// 🎉 SUCCESS MESSAGE
  //     TLoaders.successSnackBar(title: 'Success', message: 'Login successful');
  //   } catch (e) {
  //     /// 🛑 STOP LOADER SAFELY
  //     TLoaders.stopLoading();

  //     /// ❗ SHOW ERROR
  //     TLoaders.errorSnackBar(
  //       title: 'Oh Snap!',
  //       message: e.toString().replaceAll('Exception:', '').trim(),
  //     );
  //   }
  // }

  Future<void> signInUser({
    required BuildContext context,
    required String email,
    required String password,
    q,
  }) async {
    try {
      /// 🔄 START LOADING
      TLoaders.openLoadingDialog('Logging you in...', TImages.docerAnimation);

      /// 🌐 CHECK INTERNET
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        throw 'No internet connection';
      }

      /// 📡 1. API CALL - SIGN IN
      final response = await http.post(
        Uri.parse('$uri/api/signin'),
        headers: const {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'email': email.trim(), 'password': password.trim()}),
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
      final String token = decoded['token'];
      final userMap = decoded['user'];

      /// 📡 2. FETCH COMPLETE USER DETAILS
      final userDetailsResponse = await http.get(
        Uri.parse('$uri/api/userDetails'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
          'x-auth-token': token, // Cover both standard auth header types
        },
      );

      Map<String, dynamic> finalUserData = userMap;
      if (userDetailsResponse.statusCode == 200) {
        final decodedDetails = jsonDecode(userDetailsResponse.body);
        finalUserData = {...userMap, ...decodedDetails};
      }

      final userJson = jsonEncode(finalUserData);

      /// 💾 3. SAVE FRESH DATA TO LOCAL STORAGE FIRST
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString('user', userJson);

      /// 🧠 4. UPDATE RIVERPOD STATE
      final container = ProviderScope.containerOf(context);

      // Update state directly after storage is updated
      container.read(userProvider.notifier).setUser(userJson);

      if (Get.isRegistered<UserController>()) {
        UserController.instance.setUser(finalUserData);
      }
      // Reset and reload cart state for the new user
      container.invalidate(cartProvider);
      final String userId = finalUserData['id'] ?? finalUserData['_id'] ?? '';
      if (userId.isNotEmpty) {
        await container.read(cartProvider.notifier).loadUserCart(userId);
      }

      /// 🛑 STOP LOADER
      TLoaders.stopLoading();

      /// 🚀 NAVIGATION
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
          (route) => false,
        );
      }

      /// 🎉 SUCCESS MESSAGE
      TLoaders.successSnackBar(title: 'Success', message: 'Welcome back!');
    } catch (e) {
      /// 🛑 STOP LOADER SAFELY
      TLoaders.stopLoading();

      /// ❗ SHOW ERROR
      TLoaders.errorSnackBar(
        title: 'Oh Snap!',
        message: e.toString().replaceAll('Exception:', '').trim(),
      );
    }
  }
}
