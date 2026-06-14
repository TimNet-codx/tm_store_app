import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tm_store_app/feastures/shop/models/merged_model.dart';
import 'package:tm_store_app/service/global_variables.dart';

// class BrandController extends GetxController {
//   static BrandController get instance => Get.find();

//   var categories = <CategoryDataModel>[].obs;
//   var isLoading  = false.obs;


//   @override
//   void onInit() {
//   super.onInit();
//   initializeData();
// }

// Future<void> initializeData() async {
//   // Start all fetches at the same time
//   await Future.wait(
//     [fetBrandProductData()]
//   );
// }

// Future<void> fetBrandProductData() async {
// try{
//   isLoading.value = true;
//   http.Response response = await http.get(Uri.parse("$uri/api/get-brandwithProduct-data"),
//   headers: <String, String>{
//         "Content-Type": "application/json; charset=UTF-8",
//       },
  
//   );
//   if(response.statusCode == 200){
//     // The Backend now return a list of grouped objects
//     final List<dynamic> data = jsonDecode(response.body);

//     // Map the JSON list to your CategoryDataModel list
//     categories.assignAll(data.map((json) => CategoryDataModel.fromJson(json)).toList());

//     print("Fetched ${categories.length} Merged Categories");
//         if (categories.isNotEmpty) {
//           print("First Category: ${categories[0].name} has ${categories[0].products.length} products");
//         }
//   }else{
//     print("Failed to fetch brand product data. Status code: ${response.statusCode}");
//   }
// } catch(e) {
//     print("FRONTEND FETCH ERROR: $e");
// } finally{
// isLoading.value = false;
// }
// }
// }


class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  var categories = <CategoryDataModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
  super.onInit();
  initializeData();
}

Future<void> initializeData() async {
  // Start all fetches at the same time
  await Future.wait(
    [fetBrandProductData()]
  );
}

// Future<void> fetBrandProductData() async {
//   try {
//     isLoading.value = true;
    
//     final response = await http.get(
//       Uri.parse("$uri/api/get-brandwithProduct-data"),
//       headers: {"Content-Type": "application/json; charset=UTF-8"},
//     );

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> decodedData = jsonDecode(response.body);

//       // 1. Check the 'success' flag from your backend
//       if (decodedData['success'] == true) {
        
//         // 2. Map the brands and products separately 
//         // Note: Your CategoryDataModel might need adjustment if you are trying 
//         // to force these into a "Category" structure.
        
//         final List<dynamic> brandsJson = decodedData['brands'] ?? [];
//         final List<dynamic> productsJson = decodedData['products'] ?? [];

//         // If you want to merge them into your CategoryDataModel:
//         // You have to decide how they relate. For now, let's create a 
//         // single "Virtual Category" to hold all of them:
        
//         final mergedCategory = CategoryDataModel(
//           name: "All Items",
//           totalProducts: productsJson.length,
//           brands: brandsJson.map((json) => BrandSubset.fromJson(json)).toList(),
//           products: productsJson.map((json) => ProductSubset.fromJson(json)).toList(),
//         );

//         categories.assignAll([mergedCategory]);

//         print("SUCCESS: Loaded ${brandsJson.length} brands and ${productsJson.length} products.");
//       }
//     } else {
//       print("SERVER ERROR: ${response.statusCode}");
//     }
//   } catch (e) {
//     print("FRONTEND FETCH ERROR: $e");
//   } finally {
//     isLoading.value = false;
//   }
// }


Future<void> fetBrandProductData() async {
  try {
    isLoading.value = true;
    print("DEBUG: Attempting to fetch from $uri/api/get-brandwithProduct-data");

    final response = await http.get(
      Uri.parse("$uri/api/get-brandwithProduct-data"),
      headers: {"Content-Type": "application/json; charset=UTF-8"},
    ).timeout(const Duration(seconds: 10)); // Timeout if server is unreachable

    print("DEBUG: Status Code: ${response.statusCode}");
    print("DEBUG: Raw Body: ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedData = jsonDecode(response.body);

      // Check the keys your Backend actually sends
      if (decodedData.containsKey('brands') || decodedData.containsKey('products')) {
        
        final List<dynamic> brandsJson = decodedData['brands'] ?? [];
        final List<dynamic> productsJson = decodedData['products'] ?? [];

        // We create one 'Virtual Category' to hold the un-grouped data
        final mergedCategory = CategoryDataModel(
          name: "All Brands",
          totalProducts: productsJson.length,
          brands: brandsJson.map((json) => BrandSubset.fromJson(json)).toList(),
          products: productsJson.map((json) => ProductSubset.fromJson(json)).toList(),
        );

        categories.assignAll([mergedCategory]);
        print("DEBUG: Success! Loaded ${categories[0].brands.length} brands into categories list.");
      } else {
        print("DEBUG: Keys 'brands' or 'products' not found in JSON");
      }
    }
  } catch (e) {
    print("DEBUG: CRITICAL ERROR: $e");
  } finally {
    isLoading.value = false;
  }
}


}