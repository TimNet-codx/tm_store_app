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
  final productDetails = <ProductModel>[].obs;

  final isLoading = false.obs;

  Map<String, String> get _headers => {"Content-Type": "application/json; charset=UTF-8", "Accept": "application/json"};
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
    await Future.wait([fetchFavouriteProducts(), fetchPopularProducts(), fetchAllProducts(), getProductById("initialProductId", "initialCategory")]);

    // Once all are done, sync the hearts
    syncFavouriteStatus();
  }

  Future<void> fetchPopularProducts() async {
    try {
      isLoading.value = true;

      // ❌ REMOVE THIS LINE:
      // if (favouriteProducts.isEmpty) { await fetchFavouriteProducts(); }

      http.Response response = await http.get(Uri.parse("$uri/api/get-popular-products"), headers: {"Content-Type": "application/json; charset=UTF-8"});

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

  Future<void> fetchAllProducts() async {
    try {
      isLoading.value = true;

      // ❌ REMOVE THIS LINE:
      // if (favouriteProducts.isEmpty) { await fetchFavouriteProducts(); }

      http.Response response = await http.get(Uri.parse("$uri/api/get-all-products"), headers: {"Content-Type": "application/json; charset=UTF-8"});

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

  // Add or Remove from Favourite (Wishlist) with Optimistic UI and Error Handling
  Future<void> addAndRemoveFavouriteProduct(String productId) async {
    // 1. Initial State Capture
    final bool wasFavourite = favouriteProducts.any((p) => p.id == productId);
    ProductModel? productToToggle;

    try {
      // 2. Find product in ANY available list (Popular or All)
      productToToggle = allProducts.firstWhereOrNull((p) => p.id == productId) ?? popularProducts.firstWhereOrNull((p) => p.id == productId);

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
      final response = await http
          .post(
            Uri.parse("$uri/api/toggle-favourite"),
            headers: {
              "Content-Type": "application/json; charset=UTF-8",
              // Add auth headers here if your backend requires them later
            },
            body: jsonEncode({"productId": productId.trim()}),
          )
          .timeout(const Duration(seconds: 10)); // Timeout if server is slow

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

        // Get.snackbar(
        //   "Success",
        //   wasFavourite ? "Removed from Wishlist" : "Added to Wishlist",
        //   snackPosition: SnackPosition.BOTTOM,
        //   backgroundColor: Colors.green.withOpacity(0.8),
        //   colorText: Colors.white,
        //   duration: const Duration(seconds: 1),
        // );
      } else {
        // Logic failure (e.g., 400, 404, 500)
        //_rollback(wasFavourite, productToToggle);
        final errorData = jsonDecode(response.body);
        Get.snackbar("Error", errorData['msg'] ?? "Server error: ${response.statusCode}");
      }
    } on SocketException catch (e) {
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

  // Get Favourite Status of a Product (Used for UI)
  Future<void> fetchFavouriteProducts() async {
    try {
      isLoading.value = true;
      http.Response response = await http.get(Uri.parse("$uri/api/get-favourite-products"), headers: {"Content-Type": "application/json; charset=UTF-8"});
      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        List<dynamic> productFavouriteList;

        if (decoded is Map && decoded['favouriteProducts'] != null) {
          productFavouriteList = decoded['favouriteProducts'];
          print("PRODUCT LIST: $productFavouriteList");
        } else if (decoded is List) {
          productFavouriteList = decoded;
        } else {
          throw Exception('Unexpected response format');
        }

        final result = productFavouriteList.map((e) => ProductModel.fromMap(e)).toList();

        favouriteProducts.assignAll(result);
        print("Successfully loaded ${favouriteProducts.length} products");
      } else {
        Get.snackbar("Error", "Failed to load categories");
      }
    } on SocketException catch (e) {
      print("Network Error: $e");
      Get.snackbar("Connection Error", "Check your server connection or IP address.");
    } catch (e) {
      //   print("ERROR: $e");
      //   Get.snackbar("Error", e.toString());
      // }
      Get.snackbar("Mapping Error", e.toString(), snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white, duration: const Duration(seconds: 10));
    } finally {
      isLoading.value = false;
    }
  }

  // Get Product Details by ID (Used for Product Detail Screen)
  // Get Product Details by ID (Product Detail Screen)
  // Future<void> getProductById(String productId, String category) async {
  //   try {
  //     isLoading.value = true;

  //     final productDetails = Uri.parse("$uri/api/products/details").replace(queryParameters: {"productId": productId,"category": category});

  //     http.Response response = await http.get(productDetails,
  //        headers: {
  //         "Content-Type": "application/json; charset=UTF-8",
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       final decoded = jsonDecode(response.body);
  //       ProductDetails.assignAll([ProductDetails.fromMap(decoded["product"])]);
  //     } else {
  //       Get.snackbar("Error", "Failed to load product details");
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", e.toString());
  //     return null;
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> getProductById(String productId, String category) async {
    try {
      isLoading.value = true;

      final detailsUrl = Uri.parse("$uri/api/products/details").replace(queryParameters: {"productId": productId, "category": category});

      http.Response response = await http.get(detailsUrl, headers: {"Content-Type": "application/json; charset=UTF-8"});

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        final product = ProductModel.fromMap(decoded["product"]);

        productDetails.assignAll([product]);
      } else {
        Get.snackbar("Error", "Failed to load product details");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

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
