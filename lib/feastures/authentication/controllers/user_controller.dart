import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tm_store_app/feastures/authentication/models/user.dart';
import 'package:tm_store_app/provider/user_provider.dart';
import 'package:tm_store_app/service/global_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

final providerContainer = ProviderContainer();

// class UserController extends GetxController {
//     static UserController get instance => Get.find();

//     var user = Rxn<UserModel>(); 
//     var isLoading = false.obs;

//   @override
//   void onInit() {
//   super.onInit();
//   initializeData();
// }

// Future<void> initializeData() async {
//   // Start all fetches at the same time
//   await Future.wait(
//     [getUserData()]
//   );
// }

//   // Future<void> getUserData() async {
//   //     try {
//   //       isLoading.value = true;
        
//   //       // ✅ Use SharedPreferences here
         
//   //       final prefs = await SharedPreferences.getInstance();
        
//   //       String? token = prefs.getString('auth-token'); 
//   //       if (token == null || token.isEmpty) {
//   //         print("No token found");
//   //         return;
//   //       }

    
//   //       final response = await http.get(
//   //         Uri.parse("$uri/api/userDetails"),
//   //         headers: {
//   //           'Content-Type': 'application/json; charset=UTF-8',
//   //           'Authorization': 'Bearer $token',
//   //         },
//   //       );
//   //       final decoded = jsonDecode(response.body);
//   //        final userJson = jsonEncode(decoded['user']);
//   //        await prefs.setString('user', userJson);
//   //         /// 🧠 UPDATE APP STATE
//   //         providerContainer
//   //             .read(userProvider.notifier)
//   //             .setUser(userJson);

//   //       if (response.statusCode == 200) {
//   //         Map<String, dynamic> data = jsonDecode(response.body);
//   //         user.value = UserModel.fromMap(data);
//   //       } else {
//   //         print("Failed to fetch user data: ${response.statusCode}");
//   //       }
//   //     } catch (e) {
//   //       print("FETCH ERROR: $e");
//   //     } finally {
//   //       isLoading.value = false;
//   //     }
//   //   }

// // Future<void> getUserData() async {
// //     try {
// //       isLoading.value = true;
      
// //       final prefs = await SharedPreferences.getInstance();
// //       String? token = prefs.getString('auth-token'); 
// //       if (token == null || token.isEmpty) {
// //         print("No token found");
// //         return;
// //       }

// //       final response = await http.get(
// //         Uri.parse("$uri/api/userDetails"),
// //         headers: {
// //           'Content-Type': 'application/json; charset=UTF-8',
// //           'Authorization': 'Bearer $token',
// //         },
// //       );

// //       if (response.statusCode == 200) {
// //         final decoded = jsonDecode(response.body);
        
// //         // 🧠 Update app state & preferences strings
// //         final userJson = jsonEncode(decoded['user']);
// //         await prefs.setString('user', userJson);
// //         providerContainer.read(userProvider.notifier).setUser(userJson);

// //         // ✅ FIX: Extract the 'user' inner map map object explicitly to instantiate model fields properly
// //         if (decoded['user'] != null) {
// //           user.value = UserModel.fromMap(decoded['user']);
// //         } else {
// //           print("User key not found inside data package payload structure.");
// //         }
// //       } else {
// //         print("Failed to fetch user data: ${response.statusCode}");
// //       }
// //     } catch (e) {
// //       print("FETCH ERROR: $e");
// //     } finally {
// //       isLoading.value = false;
// //     }
// //   }

// Future<void> getUserData() async {
//   try {
//     isLoading.value = true;
    
//     final prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('auth-token'); 
//     if (token == null || token.isEmpty) {
//       print("No token found");
//       return;
//     }

//     final response = await http.get(
//       Uri.parse("$uri/api/userDetails"),
//       headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'Bearer $token',
//       },
//     );

//     if (response.statusCode == 200) {
//       // 1. Decode the root object directly (e.g., {"fullName": "...", "email": "..."})
//       final Map<String, dynamic> decoded = jsonDecode(response.body);
      
//       // 2. Convert the entire object to a string for preferences and Riverpod
//       final userJson = jsonEncode(decoded);
//       await prefs.setString('user', userJson);
//       providerContainer.read(userProvider.notifier).setUser(userJson);

//       // ✅ FIX: Pass the decoded root object straight into your model!
//       user.value = UserModel.fromMap(decoded);
      
//       print("👤 User Data Successfully Loaded: ${user.value?.fullName}");
//     } else {
//       print("Failed to fetch user data: ${response.statusCode}");
//     }
//   } catch (e) {
//     print("FETCH ERROR: $e");
//   } finally {
//     isLoading.value = false;
//   }
// }

//   }


class UserController extends GetxController {
  static UserController get instance => Get.find();

  var user = Rxn<UserModel>(); 
  var isLoading = false.obs;

  // ✅ Add an initialization method to safely load cached values
  void hydrateUserFromCache(String? userJson) {
    if (userJson != null && userJson.isNotEmpty) {
      try {
        final Map<String, dynamic> decoded = jsonDecode(userJson);
        user.value = UserModel.fromMap(decoded);
        print("👤 GetX Controller Hydrated From Cache: ${user.value?.fullName}");
      } catch (e) {
        print("⚠️ Error hydrating GetX user from cache string: $e");
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Keep this here so it can check for fresh token data in the background
    getUserData(); 
  }

  Future<void> getUserData() async {
    try {
      isLoading.value = true;
      final prefs = await SharedPreferences.getInstance();
      
      String? token = prefs.getString('auth-token'); 
      if (token == null || token.isEmpty) {
        print("No token found during background refresh");
        return;
      }

      final response = await http.get(
        Uri.parse("$uri/api/userDetails"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> decoded = jsonDecode(response.body);
        
        final userJson = jsonEncode(decoded);
        await prefs.setString('user', userJson);
        providerContainer.read(userProvider.notifier).setUser(userJson);

        // Update the state with fresh background data cleanly
        user.value = UserModel.fromMap(decoded);
      }
    } catch (e) {
      print("FETCH ERROR: $e");
    } finally {
      isLoading.value = false;
    }
  }
}