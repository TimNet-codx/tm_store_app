import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tm_store_app/feastures/authentication/models/user.dart';
import 'package:tm_store_app/service/global_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
    static UserController get instance => Get.find();

    var user = Rxn<UserModel>(); 
    var isLoading = false.obs;

  @override
  void onInit() {
  super.onInit();
  initializeData();
}

Future<void> initializeData() async {
  // Start all fetches at the same time
  await Future.wait(
    [getUserData()]
  );
}

  Future<void> getUserData() async {
      try {
        isLoading.value = true;
        
        // ✅ Use SharedPreferences here
        final prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('token'); 
        if (token == null || token.isEmpty) {
          print("No token found");
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
          Map<String, dynamic> data = jsonDecode(response.body);
          user.value = UserModel.fromMap(data);
        } else {
          print("Failed to fetch user data: ${response.statusCode}");
        }
      } catch (e) {
        print("FETCH ERROR: $e");
      } finally {
        isLoading.value = false;
      }
    }
  }