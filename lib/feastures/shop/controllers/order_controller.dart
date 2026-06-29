import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tm_store_app/feastures/shop/models/order_model.dart';
import 'package:tm_store_app/service/global_variables.dart';
import 'package:tm_store_app/service/manage_http_response.dart';

class OrderController extends GetxController {
  // final OrderRepository _orderRepository = OrderRepository();
  final orderM = <OrderModel>[].obs;
   

// void createOrder({required OrderModel order, required  context }) async {
//     try {
//       final OrderModel newOrder = OrderModel(
//         id: order.id,
//         fullName: order.fullName,
//         email: order.email,
//         state: order.state,
//         city: order.city,
//         street: order.street,
//         productName: order.productName,
//         productPrice: order.productPrice,
//         quantity: order.quantity,
//         category: order.category,
//         buyerdId: order.buyerdId,
//         vendorId: order.vendorId,
//         image: order.image,
//         processing: order.processing,
//         delivered: order.delivered, 
//       );
//  http.Response response = await http.post(
//         Uri.parse("$uri/api/add-order"),
//         body: order.toJson(),
//         headers: <String, String>{
//           "Content-Type": 'application/json; charset=UTF-8'
//         },
//       );
      
//       manageHttpResponse(response: response, context: context, onSuccess: (){ 
//         showSnackBar(context, "Order created successfully");
//         Get.snackbar('Success', 'Order created successfully');
//       });
//       Get.snackbar('Success', 'Order created successfully');
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to create order: $e');
//     }
//   }

Future<void> createOrder({ required OrderModel order, required context,}) async {
  try {
     http.Response response = await http.post(
      Uri.parse('$uri/api/add-order'),
      headers: const {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(order.toJson()),
    );

    manageHttpResponse(response: response, context: context, onSuccess: () {
        showSnackBar(context, 'Order created successfully');
        
        Get.snackbar('Success', 'Order created successfully');
      },
    );
  } catch (e) {
    Get.snackbar(
      'Error',
      'Failed to create order',
      snackPosition: SnackPosition.BOTTOM,
    );
    debugPrint('Create order error: $e');
  }
}

  Future<void> fetchOrders() async {
    try {
      //List<OrderModel> orders = await _orderRepository.fetchOrders();
      // Handle the fetched orders as needed
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch orders: $e');
    }
  }

}