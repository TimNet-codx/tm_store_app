// import 'dart:convert';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;
// import 'package:tm_store_app/feastures/shop/models/cart_model.dart';
// import 'package:tm_store_app/service/global_variables.dart';

// // A notifier class to manage the cart state, including adding, removing, and updating items in the cart. extending state notifier
// // With an inital state of an empty list of cart items, and methods to manipulate the cart state based on user interactions.

// class CartNotifier extends StateNotifier<Map<String, CartModel>>{
//    CartNotifier() : super({}); //With an inital state of an empty 


// Future<void> syncCartToDatabase(String userId) async{
//   if(userId.isEmpty) return;

//   final cartListJson = state.values.map((item) => item.toMap()).toList();
//   try{
//        final response = await http.post(
//         Uri.parse("$uri/api/cart/sync"),
//         headers: <String, String>{
//           "Content-Type": 'application/json; charset=UTF-8'
//         },
//         body: json.encode({
//           "userId": userId,
//           "items": cartListJson,
//         }),
//        );

//        if(response.statusCode == 200){
//         print("Cart synced successfully");
//        } else {
//         print("Failed to sync cart: ${response.body}");
//        }

//   }catch (e){
//     print("Error syncing cart to database: $e");
//   }

// }


// Future<void> loadUserCart(String userId) async {
//     if (userId.isEmpty) return;

//     final url = Uri.parse('$uri/api/cart?userId=$userId');

//     try {
//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         final Map<String, CartModel> loadedCart = {};

//         for (var itemMap in data) {
//           // Convert each backend map into your CartModel
//           // Note: If you have a CartModel.fromMap, use that here instead!
//           final cartItem = CartModel(
//             productId: itemMap['productId'] ?? '',
//             productName: itemMap['productName'] ?? '',
//             productPrice: (itemMap['productPrice'] as num?)?.toInt() ?? 0,
//             category: itemMap['category'] ?? '',
//             images: List<String>.from(itemMap['images'] ?? []),
//             vendorId: itemMap['vendorId'] ?? '',
//             productQuantity: (itemMap['productQuantity'] as num?)?.toInt() ?? 0,
//             quantity: (itemMap['quantity'] as num?)?.toInt() ?? 1,
//             description: itemMap['description'] ?? '',
//             fullName: itemMap['fullName'] ?? '',
//           );
          
//           loadedCart[cartItem.productId] = cartItem;
//         }

//         // Overwrite the local empty state with the retrieved database state
//         state = loadedCart;
//       }
//     } catch (e) {
//       print("Error loading cart from database: $e");
//     }
//   }

// void clearCart() {
//     state = {};
//   }

//    // Method to add product to the cart
// void addProductToCart({
//   required String productName,
//   required int productPrice,
//   required String category,
//   required List<String> images,
//   required String vendorId,
//   required int productQuantity,
//   required int quantity,
//   required String id,
//   required String description,
//   required String fullName,
//   required String userId,
//    }){
//     // Check if the product is already in the  cart
//     if(state.containsKey(id)){
//       // If the product is already in the cart, update the quantity
//       final existingCartItem = state[id]!;
//       final updatedCartItem = CartModel(
//         productName: existingCartItem.productName,
//         productPrice: existingCartItem.productPrice,
//         category: existingCartItem.category,
//         images: existingCartItem.images,
//         vendorId: existingCartItem.vendorId,
//         productQuantity: existingCartItem.productQuantity,
//         quantity: existingCartItem.quantity + 1, // Increment the quantity
//         productId: existingCartItem.productId,
//         description: existingCartItem.description,
//         fullName: existingCartItem.fullName,
//       );
//       state = {...state, id: updatedCartItem}; // Update the cart state with the new quantity
//     } else {
//       // If the product is not in the cart, add it as a new item
//       final newCartItem = CartModel(
//         productName: productName,
//         productPrice: productPrice,
//         category: category,
//         images: images,
//         vendorId: vendorId,
//         productQuantity: productQuantity,
//         quantity: quantity,
//         productId: id,
//         description: description,
//         fullName: fullName,
//       );
//       state = {...state, id: newCartItem}; // Add the new item to the cart state
//     }

//     syncCartToDatabase(userId); // Sync the updated cart to the database after adding a product
//    }


//    // Method to Increment the quantity of a product in the cart
//   //  void incrementProductQuantity(String productId){
//   //   if(state.containsKey(productId)){
//   //     final existingCartItem = state[productId]!;
//   //     final updatedCartItem = CartModel(
//   //       productName: existingCartItem.productName,
//   //       productPrice: existingCartItem.productPrice,
//   //       category: existingCartItem.category,
//   //       images: existingCartItem.images,
//   //       vendorId: existingCartItem.vendorId,
//   //       productQuantity: existingCartItem.productQuantity,
//   //       quantity: existingCartItem.quantity++, // Increment the quantity
//   //       productId: existingCartItem.productId,
//   //       description: existingCartItem.description,
//   //       fullName: existingCartItem.fullName,
//   //     );
//   //     state = {...state, productId: updatedCartItem}; // Update the cart state with the new quantity
//   //   }
//   //  }
   
//   //   void incrementProductQuantity(String productId){
//   //   if(state.containsKey(productId)){
//   //     state[productId]!.quantity++; // Update the cart state with the new quantity

//   //     // Notify listeners about the state change
//   //     state = {...state}; // Trigger a state update to notify listeners
//   //   }
//   //  }
// void incrementProductQuantity(String productId, String userId) {
//     if (state.containsKey(productId)) {
//       final item = state[productId]!;
      
//       // Fixed: Avoided using state[id]!.quantity++ directly to remain immutable
//       state = {
//         ...state,
//         productId: CartModel(
//           productName: item.productName,
//           productPrice: item.productPrice,
//           category: item.category,
//           images: item.images,
//           vendorId: item.vendorId,
//           productQuantity: item.productQuantity,
//           quantity: item.quantity + 1, // Safe Immutable update
//           productId: item.productId,
//           description: item.description,
//           fullName: item.fullName,
//         ),
//       };
      
//       syncCartToDatabase(userId);
//     }
//   }
//    // Method to Decrement the quantity of a product in the cart
//   //  void decrementProductQuantity(String productId){
//   //   if(state.containsKey(productId)){
//   //     final existingCartItem = state[productId]!;
//   //     if(existingCartItem.quantity > 1){ // Ensure that quantity does not go below 1
//   //       final updatedCartItem = CartModel(
//   //         productName: existingCartItem.productName,
//   //         productPrice: existingCartItem.productPrice,
//   //         category: existingCartItem.category,
//   //         images: existingCartItem.images,
//   //         vendorId: existingCartItem.vendorId,
//   //         productQuantity: existingCartItem.productQuantity,
//   //         quantity: existingCartItem.quantity - 1, // Decrement the quantity
//   //         productId: existingCartItem.productId,
//   //         description: existingCartItem.description,
//   //         fullName: existingCartItem.fullName,
//   //       );
//   //       state = {...state, productId: updatedCartItem}; // Update the cart state with the new quantity
//   //     }
//   //   }
//   //  }

//   //   void decrementProductQuantity(String productId){
//   //   if(state.containsKey(productId)){
//   //     state[productId]!.quantity--; // Update the cart state with the new quantity

//   //      // Notify listeners about the state change
//   //     state = {...state}; // Trigger a state update to notify listeners
//   //   }
//   //  }
//   void decrementProductQuantity(String productId, String userId){ {
//   if (state.containsKey(productId)) {
//     final item = state[productId]!;

//     // ✅ Check: If the current quantity is 1, pressing minus means it drops to 0. 
//     // So we completely delete it!
//     if (item.quantity <= 1) {
//       removeProductFromCart(productId, userId);
//     } 
//     // ✅ Otherwise, if it's 2 or more, we safely subtract 1 by creating a new copy
//     else {
//       state = {
//         ...state,
//         productId: CartModel(
//           productName: item.productName,
//           productPrice: item.productPrice,
//           category: item.category,
//           images: item.images,
//           vendorId: item.vendorId,
//           productQuantity: item.productQuantity,
//           quantity: item.quantity - 1, // Safe decrement
//           productId: item.productId,
//           description: item.description,
//           fullName: item.fullName,
//         ),
//       };

//       syncCartToDatabase(userId);
//     }
//   }
//   }
//   }



//    // Method to Remove a product from the cart
//   //  void removeProductFromCart(String productId){
//   //   if(state.containsKey(productId)){
//   //     final updatedState = Map<String, CartModel>.from(state);
//   //     updatedState.remove(productId); // Remove the product from the cart state

//   //     state = updatedState; // Update the cart state
//   //   }
//   //  }

//   void removeProductFromCart(String productId, String userId){
//     final newState = Map<String, CartModel>.from(state);
//     newState.remove(productId); // Remove the product from the cart state
//     state = newState;

//      // Notify listeners about the state change
//       state = {...state}; 
//       syncCartToDatabase(userId);// Trigger a state update to notify listeners
//   }

//   //Method to Calaculate the total price of items in the cart
//   // double calculateTotalPrice(){
//   //   double totalAmount = 0;
//   //   for (var cartItem in state.values) {
//   //     totalAmount += cartItem.productPrice * cartItem.quantity;
//   //   }
//   //   return totalAmount;
//   // }

//   double calculateTotaLAmount(){
//     double totalAmount = 0.0;
//     state.forEach((productId, cartItem) {
//       totalAmount += cartItem.quantity * cartItem.productPrice;
//     });

//     return totalAmount;
//   }
// }

// // Define a StateNotifierProvider for the cart state, allowing widgets to listen to changes in the cart and update accordingly. The provider is defined as a global variable that can be accessed throughout the app.
// // Define a StateNotifierProvider to Expose an instance of the CartNotifier
// // Make The data Accessible within the Application 

// final cartProvider = StateNotifierProvider<CartNotifier, Map<String, CartModel>>((ref) => CartNotifier());



import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:tm_store_app/feastures/shop/models/cart_model.dart';
import 'package:tm_store_app/service/global_variables.dart';

class CartNotifier extends StateNotifier<Map<String, CartModel>> {
  CartNotifier() : super({}); 

  // --- SYNC WITH BACKEND ---
  Future<void> syncCartToDatabase(String userId) async {
    if (userId.isEmpty) return;

    final cartListJson = state.values.map((item) => item.toMap()).toList();
    try {
      final response = await http.post(
        Uri.parse("$uri/api/cart/sync"),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8'
        },
        body: json.encode({
          "userId": userId,
          "items": cartListJson,
        }),
      );

      if (response.statusCode == 200) {
        print("Cart synced successfully");
      } else {
        print("Failed to sync cart: ${response.body}");
      }
    } catch (e) {
      print("Error syncing cart to database: $e");
    }
  }

  // --- FETCH FROM BACKEND ---
  Future<void> loadUserCart(String userId) async {
    if (userId.isEmpty) return;

    final url = Uri.parse('$uri/api/cart?userId=$userId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final Map<String, CartModel> loadedCart = {};

        for (var itemMap in data) {
          final cartItem = CartModel(
            productId: itemMap['productId'] ?? '',
            productName: itemMap['productName'] ?? '',
            productPrice: (itemMap['productPrice'] as num?)?.toInt() ?? 0,
            category: itemMap['category'] ?? '',
            images: List<String>.from(itemMap['images'] ?? []),
            vendorId: itemMap['vendorId'] ?? '',
            productQuantity: (itemMap['productQuantity'] as num?)?.toInt() ?? 0,
            quantity: (itemMap['quantity'] as num?)?.toInt() ?? 1,
            description: itemMap['description'] ?? '',
            fullName: itemMap['fullName'] ?? '',
            userId: itemMap['userId'] ?? '',
          
          );
          
          loadedCart[cartItem.productId] = cartItem;
        }

        state = loadedCart;
      }
    } catch (e) {
      print("Error loading cart from database: $e");
    }
  }

  /// --- CLEAR CART ---
Future<void> removeCartItemFromDatabase(String userId, String productId) async {
  if (userId.isEmpty || productId.isEmpty) return;

  try {
    // 1. Point to your refined remove-item endpoint
    final url = Uri.parse("$uri/api/cart/remove-item");
    
    // 2. Perform an HTTP DELETE request to match the backend router verb
    final response = await http.delete(
      url,
      headers: <String, String>{
        "Content-Type": 'application/json; charset=UTF-8'
      },
      // 3. Send both required keys inside the JSON raw payload string payload context
      body: json.encode({
        "userId": userId,
        "productId": productId,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print("🎯 Frontend Sync Success: ${responseData['message']}");
    } else {
      print("❌ Failed to update item status in database: ${response.body}");
    }
  } catch (e) {
    print("❌ Error communicating item removal request to database: $e");
  }
}

  void clearCart() {
    state = {};
  }

  // --- ADD TO CART ---
  void addProductToCart({
    required String productName,
    required int productPrice,
    required String category,
    required List<String> images,
    required String vendorId,
    required int productQuantity,
    required int quantity,
    required String id,
    required String description,
    required String fullName,
    required String userId,
  }) {
    if (state.containsKey(id)) {
      final existingCartItem = state[id]!;
      final updatedCartItem = CartModel(
        productName: existingCartItem.productName,
        productPrice: existingCartItem.productPrice,
        category: existingCartItem.category,
        images: existingCartItem.images,
        vendorId: existingCartItem.vendorId,
        productQuantity: existingCartItem.productQuantity,
        quantity: existingCartItem.quantity + 1, 
        productId: existingCartItem.productId,
        description: existingCartItem.description,
        fullName: existingCartItem.fullName,
        userId: existingCartItem.userId,
      );
      // ✅ Dynamic Key Evaluation Fix
      state = {...state, id: updatedCartItem}; 
    } else {
      final newCartItem = CartModel(
        productName: productName,
        productPrice: productPrice,
        category: category,
        images: images,
        vendorId: vendorId,
        productQuantity: productQuantity,
        quantity: quantity,
        productId: id,
        description: description,
        fullName: fullName,
        userId: userId
      );
      // ✅ Dynamic Key Evaluation Fix
      state = {...state, id: newCartItem}; 
    }

    syncCartToDatabase(userId); 
  }

  // --- INCREMENT PRODUCT ---
  void incrementProductQuantity(String productId, String userId) {
    if (state.containsKey(productId)) {
      final item = state[productId]!;
      
      // ✅ Fix: Changed 'productId:' to '[productId]:' to parse dynamic value evaluation
      state = {
        ...state,
        productId: CartModel(
          productName: item.productName,
          productPrice: item.productPrice,
          category: item.category,
          images: item.images,
          vendorId: item.vendorId,
          productQuantity: item.productQuantity,
          quantity: item.quantity + 1, 
          productId: item.productId,
          description: item.description,
          fullName: item.fullName,
          userId: item.userId,
        ),
      };
      
      syncCartToDatabase(userId);
    }
  }

  // --- DECREMENT PRODUCT ---
  void decrementProductQuantity(String productId, String userId) {
    if (state.containsKey(productId)) {
      final item = state[productId]!;

      if (item.quantity <= 1) {
        removeProductFromCart(productId, userId);
        removeCartItemFromDatabase(userId, productId);
      } else {
        // ✅ Fix: Changed 'productId:' to '[productId]:' to parse dynamic value evaluation
        state = {
          ...state,
           productId: CartModel(
            productName: item.productName,
            productPrice: item.productPrice,
            category: item.category,
            images: item.images,
            vendorId: item.vendorId,
            productQuantity: item.productQuantity,
            quantity: item.quantity - 1, 
            productId: item.productId,
            description: item.description,
            fullName: item.fullName,
            userId: item.userId,
          ),
        };

        syncCartToDatabase(userId);
        removeCartItemFromDatabase(productId, userId);
      }
    }
  }

  // --- REMOVE PRODUCT ---
  void removeProductFromCart(String productId, String userId) {
    final newState = Map<String, CartModel>.from(state);
    newState.remove(productId); 
    state = newState;
    
    syncCartToDatabase(userId);
  }

  double calculateTotaLAmount() {
    double totalAmount = 0.0;
    state.forEach((productId, cartItem) {
      totalAmount += cartItem.quantity * cartItem.productPrice;
    });
    return totalAmount;
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, Map<String, CartModel>>((ref) => CartNotifier());