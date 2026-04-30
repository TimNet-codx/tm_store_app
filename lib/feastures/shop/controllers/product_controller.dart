import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tm_store_app/feastures/shop/models/product_model.dart';
import 'package:tm_store_app/service/global_variables.dart';


class ProductController extends GetxController {

  final popularProducts = <ProductModel>[].obs;
  final allProducts = <ProductModel>[].obs;
  final favouriteProducts = <ProductModel>[].obs;

  final isLoading = false .obs;

Map<String, String> get _headers => {
    "Content-Type": "application/json; charset=UTF-8",
    "Accept": "application/json",
  };
  // @override
  // void onInit() {
  //   fetchPopularProducts();
  //   fetchAllProducts();
  //   fetchFavouriteProducts();
  //   super.onInit();
  // }

// @override
// void onInit() {
//   super.onInit();
//   loadInitialData();
// }

//   Future<void> loadInitialData() async {
//   await fetchFavouriteProducts(); // Load this FIRST
//   fetchPopularProducts();        // Then load these
//   fetchAllProducts();
// }

@override
void onInit() {
  super.onInit();
  initializeData();
}

Future<void> initializeData() async {
  // Start all fetches at the same time
  await Future.wait([
    fetchFavouriteProducts(),
    fetchPopularProducts(),
    fetchAllProducts(),
  ]);

  // Once all are done, sync the hearts
  syncFavouriteStatus();
}

Future<void> fetchPopularProducts() async {
  try {
    isLoading.value = true;

    // ❌ REMOVE THIS LINE: 
    // if (favouriteProducts.isEmpty) { await fetchFavouriteProducts(); }

    http.Response response = await http.get(
      Uri.parse("$uri/api/get-popular-products"),
      headers: {"Content-Type": "application/json; charset=UTF-8"},
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      List<dynamic> productList;

      if (decoded is Map && decoded['popularProducts'] != null) {
        productList = decoded['popularProducts'];
      } else if (decoded is List) {
        productList = decoded;
      } else {
        throw Exception('Unexpected response format');
      }

      final result = productList.map((e) => ProductModel.fromMap(e)).toList();

      // ✅ STEP 1: Load the products immediately
      popularProducts.assignAll(result);
      
      // ✅ STEP 2: Update their favourite status AFTER loading
      syncFavouriteStatus();

    } else {
      Get.snackbar("Error", "Failed to load products");
    }
  } catch (e) {
    Get.snackbar("Error", e.toString());
  } finally {
    isLoading.value = false;
  }
}

// Future<void> fetchPopularProducts() async {
//   try {
//     isLoading.value = true;

//     // Ensure we have favourites to compare against
//     if (favouriteProducts.isEmpty) {
//       await fetchFavouriteProducts();
//     }

//     http.Response response = await http.get(
//       Uri.parse("$uri/api/get-popular-products"),
//       headers: {"Content-Type": "application/json; charset=UTF-8"},
//     );

//     if (response.statusCode == 200) {
//       final decoded = jsonDecode(response.body);
//       List<dynamic> productList;

//       if (decoded is Map && decoded['popularProducts'] != null) {
//         productList = decoded['popularProducts'];
//       } else if (decoded is List) {
//         productList = decoded;
//       } else {
//         throw Exception('Unexpected response format');
//       }

//       final result = productList.map((e) {
//         final product = ProductModel.fromMap(e);
        
//         // Sync favourited status
//         product.favourite = favouriteProducts.any((fav) => fav.id == product.id);
        
//         return product;
//       }).toList();

//       popularProducts.assignAll(result);
//     } else {
//       Get.snackbar("Error", "Failed to load popular products");
//     }
//   } catch (e) {
//     Get.snackbar("Error", e.toString());
//   } finally {
//     isLoading.value = false;
//   }
// }


  // Future<void> fetchAllProducts() async{
  //   try {
  //   isLoading.value = true;
  //    http.Response response = await http.get(Uri.parse("$uri/api/get-all-products"),
  //     headers: {"Content-Type": "application/json; charset=UTF-8"},
  //   );
  //   print("STATUS: ${response.statusCode}");
  //   print("BODY: ${response.body}");

  //   if(response.statusCode == 200){
  //      final  decoded = jsonDecode(response.body);

  //     List<dynamic> productAllList;

  //     if (decoded is Map && decoded['allProducts'] != null){
  //       productAllList = decoded['allProducts'];
  //       print("PRODUCT LIST: $productAllList");

  //     } else if (decoded is List){
  //       productAllList = decoded;
  //     } else {
  //       throw Exception('Unexpected response format');
  //     }

  //     final result = productAllList.map((e) => ProductModel.fromMap(e)).toList();

  //     allProducts.assignAll(result);
  //     print("Successfully loaded ${allProducts.length} products");
  //   } else{
  //     Get.snackbar("Error", "Failed to load categories");
  //   }
  // } on SocketException catch (e) {
  //   print("Network Error: $e");
  //   Get.snackbar("Connection Error", "Check your server connection or IP address.");
  // }
  // catch (e) {
  // //   print("ERROR: $e");
  // //   Get.snackbar("Error", e.toString());
  // // } 
  //   Get.snackbar("Mapping Error", e.toString(), 
  //   snackPosition: SnackPosition.BOTTOM,
  //   backgroundColor: Colors.red,
  //   colorText: Colors.white,
  //   duration: const Duration(seconds: 10),
  // );} finally {
  //      isLoading.value = false;
  //   }
  // }

// Future<void> fetchAllProducts() async {
//   try {
//     isLoading.value = true;
    
//     // 1. Always make sure favourites are loaded first for comparison
//     if (favouriteProducts.isEmpty) {
//       await fetchFavouriteProducts();
//     }

//     http.Response response = await http.get(
//       Uri.parse("$uri/api/get-all-products"),
//       headers: {"Content-Type": "application/json; charset=UTF-8"},
//     );

//     if (response.statusCode == 200) {
//       final decoded = jsonDecode(response.body);
//       List<dynamic> productAllList;

//       if (decoded is Map && decoded['allProducts'] != null) {
//         productAllList = decoded['allProducts'];
//       } else if (decoded is List) {
//         productAllList = decoded;
//       } else {
//         throw Exception('Unexpected response format');
//       }

//       // 2. Map the results and check against our favourite list
//       final result = productAllList.map((e) {
//         final product = ProductModel.fromMap(e);
        
//         // Sync the 'favourite' boolean based on our local favourite list
//         product.favourite = favouriteProducts.any((fav) => fav.id == product.id);
        
//         return product;
//       }).toList();

//       allProducts.assignAll(result);
//     } else {
//       Get.snackbar("Error", "Failed to load products");
//     }
//   } catch (e) {
//     Get.snackbar("Error", e.toString());
//   } finally {
//     isLoading.value = false;
//   }
// }

Future<void> fetchAllProducts() async {
  try {
    isLoading.value = true;

    // ❌ REMOVE THIS LINE: 
    // if (favouriteProducts.isEmpty) { await fetchFavouriteProducts(); }

    http.Response response = await http.get(
      Uri.parse("$uri/api/get-all-products"),
      headers: {"Content-Type": "application/json; charset=UTF-8"},
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      List<dynamic> productAllList;

      if (decoded is Map && decoded['allProducts'] != null) {
        productAllList = decoded['allProducts'];
      } else if (decoded is List) {
        productAllList = decoded;
      } else {
        throw Exception('Unexpected response format');
      }

      final result = productAllList.map((e) => ProductModel.fromMap(e)).toList();

      // ✅ STEP 1: Load the products immediately
      allProducts.assignAll(result);
      
      // ✅ STEP 2: Update their favourite status AFTER loading
      syncFavouriteStatus();

    } else {
      Get.snackbar("Error", "Failed to load products");
    }
  } catch (e) {
    Get.snackbar("Error", e.toString());
  } finally {
    isLoading.value = false;
  }
}

//
// Future<void> addAndRemoveFavouriteProduct(String id) async {
//   try {
//     final productToToggle = allProducts.firstWhere((p) => p.id == id);
// print("Attempting to toggle ID: $id");
//   print("Current Favourites IDs: ${favouriteProducts.map((e) => e.id).toList()}");
//     // 1. Optimistic UI Update
//     bool wasFavourite = favouriteProducts.any((p) => p.id == id);
//     if (wasFavourite) {
//       favouriteProducts.removeWhere((p) => p.id == id);
//     } else {
//       favouriteProducts.add(productToToggle);
//     }
    
//     // ✅ Crucial: Tell GetX the list has changed
//     favouriteProducts.refresh(); 

//     http.Response response = await http.post(
//       Uri.parse("$uri/api/toggle-favourite"),
//       headers: {"Content-Type": "application/json; charset=UTF-8"},
//       body: jsonEncode({"productId": id}),
//     );

//     if (response.statusCode >= 200 && response.statusCode < 300) {
//       if (wasFavourite) {
//         favouriteProducts.add(productToToggle);
//       } else {
//         favouriteProducts.removeWhere((p) => p.id == id);
//       }
//       favouriteProducts.refresh(); // Refresh again on rollback
//       Get.snackbar("Error", "Failed to update server");
//     } else {
//       // It actually worked!
//       Get.snackbar("Success", "Favourite updated!");
//     }
//   } catch (e) {
//     Get.snackbar("Error", "Something went wrong: $e");
//   }
// }

Future<void> addAndRemoveFavouriteProduct(String productId) async {
  // 1. Initial State Capture
  final bool wasFavourite = favouriteProducts.any((p) => p.id == productId);
  ProductModel? productToToggle;

  try {
    // 2. Find product in ANY available list (Popular or All)
    productToToggle = allProducts.firstWhereOrNull((p) => p.id == productId) ?? 
                      popularProducts.firstWhereOrNull((p) => p.id == productId);

    if (productToToggle == null) {
      Get.snackbar("Error", "Product details not found localy.");
      return;
    }

    // 3. Optimistic UI Update
    if (wasFavourite) {
      favouriteProducts.removeWhere((p) => p.id == productId);
    } else {
      favouriteProducts.add(productToToggle);
    }
    favouriteProducts.refresh(); 

    // 4. Network Request - Use a Timeout to prevent infinite hanging
    final response = await http.post(
      Uri.parse("$uri/api/toggle-favourite"),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        // Add auth headers here if your backend requires them later
      },
      body: jsonEncode({"productId": productId.trim()}),
    ).timeout(const Duration(seconds: 10)); // Timeout if server is slow

    // 5. Handle Response
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      bool serverFavStatus = data['favourite'];

      // Update the local product object property directly 
      // to ensure the UI stays consistent with the DB
      productToToggle.favourite = serverFavStatus;
      
      // Force GetX to redraw the hearts
      allProducts.refresh();
      popularProducts.refresh();
      favouriteProducts.refresh();

      Get.snackbar(
        "Success", 
        wasFavourite ? "Removed from Wishlist" : "Added to Wishlist",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 1),
      );
    } 
    else {
      // Logic failure (e.g., 400, 404, 500)
      //_rollback(wasFavourite, productToToggle);
      final errorData = jsonDecode(response.body);
      Get.snackbar("Error", errorData['msg'] ?? "Server error: ${response.statusCode}");
    }

  } on SocketException catch (e) {
   // _rollback(wasFavourite, productToToggle);
    Get.snackbar("Network Error", "Cannot reach server. Check your IP/Wi-Fi.");
    print("Socket Error: $e");
  } on TimeoutException catch (_) {
   // _rollback(wasFavourite, productToToggle);
    Get.snackbar("Timeout", "Server is taking too long to respond.");
  } catch (e) {
   // _rollback(wasFavourite, productToToggle);
    Get.snackbar("Error", "An unexpected error occurred.");
    print("Favourite Error Details: $e");
  }
}
// Future<void> addAndRemoveFavouriteProduct(String productId) async {
//     // 1. Initial State Capture
//     final bool wasFavourite = favouriteProducts.any((p) => p.id == productId);
    
//     // Find the product in any active list
//     final productToToggle = allProducts.firstWhereOrNull((p) => p.id == productId) ?? 
//                           popularProducts.firstWhereOrNull((p) => p.id == productId);

//     if (productToToggle == null) return;

//     try {
//       // 2. Optimistic UI Update
//       _updateLocalLists(productId, productToToggle, !wasFavourite);

//       // 3. Server Sync
//       final response = await http.post(
//         Uri.parse("$uri/api/toggle-favourite"),
//         headers: _headers,
//         body: jsonEncode({"productId": productId.trim()}),
//       ).timeout(const Duration(seconds: 10));

//       if (response.statusCode != 200) {
//         throw HttpException("Failed with status: ${response.statusCode}");
//       }

//       // Success Snackbar
//       Get.snackbar(
//         "Success", 
//         !wasFavourite ? "Added to Wishlist" : "Removed from Wishlist",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.green.withOpacity(0.8),
//         colorText: Colors.white,
//       );

//     } catch (e) {
//       // 4. Rollback on any failure
//       _updateLocalLists(productId, productToToggle, wasFavourite);
      
//       String errorMsg = e is SocketException ? "Check your internet." : "Could not update server.";
//       Get.snackbar("Error", errorMsg, backgroundColor: Colors.redAccent);
//       print("Toggle Error: $e");
//     }
//   }

  /// Helper to keep UI in sync across multiple lists
  // void _updateLocalLists(String id, ProductModel product, bool isFav) {
  //   if (isFav) {
  //     if (!favouriteProducts.any((p) => p.id == id)) favouriteProducts.add(product);
  //   } else {
  //     favouriteProducts.removeWhere((p) => p.id == id);
  //   }
    
  //   // Update local boolean property if your model has one
  //   product.favourite = isFav;
    
  //   favouriteProducts.refresh();
  //   allProducts.refresh();
  //   popularProducts.refresh();
  // }

// Helper function to handle the rollback logic to keep code clean
// void _rollback(bool wasFavourite, ProductModel? product) {
//   if (product == null) return;
  
//   if (wasFavourite) {
//     // If it was a favorite before, add it back
//     if (!favouriteProducts.any((p) => p.productId == product.productId)) {
//       favouriteProducts.add(product);
//     }
//   } else {
//     // If it wasn't a favorite, remove it
//     favouriteProducts.removeWhere((p) => p.productId == product.productId);
//   }
//   favouriteProducts.refresh();
// }


  Future<void> fetchFavouriteProducts() async{
    try {
    isLoading.value = true;
     http.Response response = await http.get(Uri.parse("$uri/api/get-favourite-products"),
      headers: {"Content-Type": "application/json; charset=UTF-8"},
    );
    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");

    if(response.statusCode == 200){
       final  decoded = jsonDecode(response.body);

      List<dynamic> productFavouriteList;

      if (decoded is Map && decoded['favouriteProducts'] != null){
        productFavouriteList = decoded['favouriteProducts'];
        print("PRODUCT LIST: $productFavouriteList");

      } else if (decoded is List){
        productFavouriteList = decoded;
      } else {
        throw Exception('Unexpected response format');
      }

      final result = productFavouriteList.map((e) => ProductModel.fromMap(e)).toList();

      favouriteProducts.assignAll(result);
      print("Successfully loaded ${favouriteProducts.length} products");
    } else{
      Get.snackbar("Error", "Failed to load categories");
    }
  } on SocketException catch (e) {
    print("Network Error: $e");
    Get.snackbar("Connection Error", "Check your server connection or IP address.");
  }
  catch (e) {
  //   print("ERROR: $e");
  //   Get.snackbar("Error", e.toString());
  // } 
    Get.snackbar("Mapping Error", e.toString(), 
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red,
    colorText: Colors.white,
    duration: const Duration(seconds: 10),
  );} finally {
       isLoading.value = false;
    }
  }

// Future<void> fetchPopularProducts() async {
//   try {
//     isLoading.value = true;

//     http.Response response = await http.get(
//       Uri.parse("$uri/api/get-popular-products"),
//       headers: {"Content-Type": "application/json; charset=UTF-8"},
//     );

//     if (response.statusCode == 200) {
//       final decoded = jsonDecode(response.body);

//       // 1. Safe extraction of the list
//       List<dynamic> list = [];
//       if (decoded is List) {
//         list = decoded;
//       } else if (decoded is Map && decoded['popularProducts'] != null) {
//         list = decoded['popularProducts'];
//       }

//       // 2. USE .fromMap instead of .fromJson
//       // Also, we use a try-catch inside the map to see exactly which product fails
//       final result = list.map((e) {
//         try {
//           return ProductModel.fromMap(e); 
//         } catch (error) {
//           print("Mapping failed for item: $e");
//           print("Specific Error: $error");
//           return null;
//         }
//       }).whereType<ProductModel>().toList();

//       // 3. Update the RxList
//       popularProducts.assignAll(result);
//       print("Successfully assigned ${result.length} products to UI");
//     }
//   } catch (e) {
//     // If it jumps here, it's likely a type mismatch in the model fields
//     print("popularProducts Error: $e");
//   } finally {
//     isLoading.value = false;
//   }
// }



// Future<void> fetchAllProducts() async{
// try {
//     isLoading.value = true;
//      http.Response response = await http.get(Uri.parse("$uri/api/get-all-products"),
//       headers: {"Content-Type": "application/json; charset=UTF-8"},
//     );
//     print("STATUS: ${response.statusCode}");
//     print("BODY: ${response.body}");

//     if(response.statusCode == 200){
//        final  decoded = jsonDecode(response.body);
//       List<dynamic> productList;
//       if (decoded is Map && decoded['products'] != null){
//         productList = List.from(decoded['products']);
//       } else if (decoded is List){
//         productList = decoded;
//       } else {
//         throw Exception('Unexpected response format');
//       }

//      // final result = productList.map((e) => ProductModel.fromJson(e)).toList();

//      // allProducts.assignAll(result);
//     } else{
//       Get.snackbar("Error", "Failed to load categories");
//     }
//   } on SocketException catch (e) {
//     print("Network Error: $e");
//     Get.snackbar("Connection Error", "Check your server connection or IP address.");
//   }
//   catch (e) {
//     print("ERROR: $e");
//     Get.snackbar("Error", e.toString());
//   } finally {
//     isLoading.value = false;
//   }
// }


void syncFavouriteStatus() {
  // Update Popular Products
  for (var product in popularProducts) {
    product.favourite = favouriteProducts.any((fav) => fav.id == product.id);
  }
  popularProducts.refresh();

  // Update All Products
  for (var product in allProducts) {
    product.favourite = favouriteProducts.any((fav) => fav.id == product.id);
  }
  allProducts.refresh();
}
}