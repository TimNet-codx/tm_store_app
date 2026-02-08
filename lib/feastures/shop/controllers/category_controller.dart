// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:tm_store_app/global_variables.dart';
// import 'package:tm_store_app/models/category_model.dart';
// import 'package:tm_store_app/models/subCategory_model.dart';

// class CategoryController {

  
//    Future<List<CategoryMode>> getCategory() async {
//     try {
//          http.Response response = await http.get(Uri.parse("$uri/api/categories"),
//           headers: <String, String>{
//         "Content-Type": 'application/json; charset=UTF-8'
//        });
//       // print(response.body);
   
//       if (response.statusCode == 200) {
//       final Map<String, dynamic> data = jsonDecode(response.body);

//       // 👇 CHANGE THIS KEY to match your API
//       final List<dynamic> categoryList = data['categories'];

//       return categoryList
//           .map((category) => CategoryMode.fromJson(category))
//           .toList();
//     } else {
//       throw Exception('Failed to load Categories');
//     }
//   } catch (e) {
//     throw Exception('Error loading Categories: $e');
//   }
//   }

// Future<List<SubCategoryMode>> getSubCategory() async {
//   try {
//     final response = await http.get(
//       Uri.parse("$uri/api/subcategories"),
//       headers: {
//         "Content-Type": "application/json; charset=UTF-8",
//       },
//     );

//     // print("RAW RESPONSE: ${response.body}");

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> decoded = jsonDecode(response.body);

//       // ✅ MUST match backend key
//       final List<dynamic> subCategoryList = decoded['subCategories'];

//       return subCategoryList
//           .map((e) => SubCategoryMode.fromJson(e))
//           .toList();
//     } else {
//       throw Exception('Failed to load SubCategories');
//     }
//   } catch (e) {
//     throw Exception('Error loading SubCategories: $e');
//   }
// }
// }

import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tm_store_app/feastures/shop/controllers/subCategory_controller.dart';
import 'package:tm_store_app/feastures/shop/models/category_model.dart';
import 'package:tm_store_app/service/global_variables.dart';


class CategoryController extends GetxController {

  final categories = <CategoryMode>[].obs;
  final isLoading = false .obs;
  final isCategoryDetailsLoading = false.obs;

  //final SubCategoryController subCategoryController = Get.put<SubCategoryController>();
final SubCategoryController subCategoryController = Get.put(SubCategoryController());


  // final selectedCategoryId = ''.obs;
    final selectedCategoryId = RxnString();
    final selectedCategoryName = ''.obs;
    final selectedCategoryBanner = ''.obs;
   


  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

//  void selectCategory(String id, String name, String banner ) {
//     selectedCategoryId.value = id;
//     selectedCategoryName.value = name;
//     selectedCategoryBanner.value = banner;

//     print("Selected ID: $id");
//   }

void selectCategory(CategoryMode category, String id, String name, String banner) async {
  selectedCategoryId.value = category.id;
  selectedCategoryName.value = category.name;
  selectedCategoryBanner.value = category.banner;
  isCategoryDetailsLoading.value = true;

  // simulate / fetch products here if needed
  // await subCategoryController.fetchProductsByCategoriesName();

  // final subController = Get.find<SubCategoryController>();
  // await subController.fetchProductsByCategoriesName(category.name);

  //selectedCategoryBanner.value = category; // after fetch
  isCategoryDetailsLoading.value = false;
}

  // // 🔥 API CALL
  // Future<void> fetchCategories() async {
  //   try {
  //     isLoading.value = true;

  //     http.Response response = await http.get(
  //       Uri.parse("$uri/api/categories"),
  //       headers: {"Content-Type": "application/json; charset=UTF-8"},
  //     );

  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> data = jsonDecode(response.body);

  //       final List<dynamic> categoryList = data['categories'];

  //       final result = categoryList
  //           .map((category) => CategoryMode.fromJson(category))
  //           .toList();

  //       categories.assignAll(result); // ✅ update RxList
  //     } else {
  //       Get.snackbar("Error", "Failed to load categories");
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", e.toString());
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }


  Future<void> fetchCategories() async {
  try {
    isLoading.value = true;

    http.Response response = await http.get(
      Uri.parse("$uri/api/categories"),
      headers: {"Content-Type": "application/json; charset=UTF-8"},
    );

    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      List<dynamic> categoryList;

      // ✅ if API returns { categories: [...] }
      if (decoded is Map && decoded['categories'] != null) {
        categoryList = decoded['categories'];
      }
      // ✅ if API returns [ ... ]
      else if (decoded is List) {
        categoryList = decoded;
      } 
      else {
        throw Exception("Unexpected API format");
      }

      final result = categoryList
          .map((e) => CategoryMode.fromJson(e))
          .toList();

      categories.assignAll(result);

       // ✅ SET DEFAULT ONLY ONCE
        if (selectedCategoryId.value == null && categories.isNotEmpty) {
          selectedCategoryId.value = categories.first.id;
        }
    } else {
      Get.snackbar("Error", "Failed to load categories");
    }
  } on SocketException catch (e) {
    print("Network Error: $e");
    Get.snackbar("Connection Error", "Check your server connection or IP address.");
  }
  catch (e) {
    print("ERROR: $e");
    Get.snackbar("Error", e.toString());
  } finally {
    isLoading.value = false;
  }
}

  // For selecting category
//  Future<void> selectCategory(String categoryName) async {
//     // Implement your logic to handle category selection
//     try {
//       isLoading.value = true;
//       http.Response response = await http.get(
//         Uri.parse("$uri/api/category/$categoryName/subcategory"),
//         headers: {"Content-Type": "application/json; charset=UTF-8"},
//       );
//     } catch (e) {
//       print(e); 
//     }finally {
//     isLoading.value = false;
//   }
//   }

}
