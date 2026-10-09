// import 'dart:convert';

// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:tm_store_app/feastures/shop/models/order_model.dart';
// import 'package:tm_store_app/service/global_variables.dart';
// import 'package:tm_store_app/service/manage_http_response.dart';

// class OrderController extends GetxController {
//   // final OrderRepository _orderRepository = OrderRepository();
//   final orderM = <OrderModel>[].obs;
//   final bool isUpdate;
//   OrderController({this.isUpdate = false});
//   final isLoading = false.obs;

//     // Variables
//   final fullName = TextEditingController();
//   final phoneNumber = TextEditingController();
//   final street = TextEditingController();
//   final city = TextEditingController();
//   final state = TextEditingController();
//   final country = TextEditingController();
//   final email = TextEditingController();

//   Future<void> createShippingAddress({
//     required OrderModel order,
//     required context,
//   }) async {
//     try {
//       http.Response response = await http.post(
//         Uri.parse('$uri/api/add-order'),
//         headers: const {'Content-Type': 'application/json; charset=UTF-8'},
//         body: jsonEncode(order.toJson()),
//       );

//       manageHttpResponse(
//         response: response,
//         context: context,
//         onSuccess: () {
//           showSnackBar(context, 'Order created successfully');

//           Get.snackbar('Success', 'Order created successfully');
//         },
//       );
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Failed to create order',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       debugPrint('Create order error: $e');
//     }
//   }

//   Future<void> updateShippingAddress({
//     required OrderModel order,
//     required BuildContext context,
//   }) async {
//     try {
//       // Sends update payload to your express backend route
//       http.Response response = await http.post(
//         Uri.parse('$uri/api/update-order-status'),
//         headers: const {'Content-Type': 'application/json; charset=UTF-8'},
//         body: jsonEncode(<String, dynamic>{
//           'orderId': order.id,
//           ...Map<String, dynamic>.from(jsonDecode(order.toJson())),
//         }),
//       );

//       manageHttpResponse(
//         response: response,
//         context: context,
//         onSuccess: () {
//           // Update order locally in the reactive GetX list if it exists
//           int index = orderM.indexWhere((e) => e.id == order.id);
//           if (index != -1) {
//             orderM[index] = order;
//           }
//           showSnackBar(context, "Order updated successfully");
//           Get.snackbar("success", "Order updated successfully");
//         },
//       );
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to fetch orders: $e');
//     }
//   }

//   Futurs({String? buyerId}) async {
//     try {
//       //List<OrderModel> orders = await _orderRepository.fetchOrders();
//       // Handle the fetched orders as needed
//       isLoading.value = true;

//       final Uri endpoint =
//           buyerId != null && buyerId.isNotEmpty
//               ? Uri.parse('$uri/api/orders/$buyerId')
//               : Uri.parse('$uri/api/orders');

//       http.Response response = await http.get(
//         endpoint,
//         headers: const {'Content-Type': 'application/json; charset=UTF-8'},
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> data = jsonDecode(response.body);

//         // Parse list of dynamic JSON objects into OrderModel instances
//         orderM.value = data.map((json) => OrderModel.fromJson(json)).toList();
//       } else {
//         Get.snackbar(
//           'Error',
//           'Failed to fetch orders: ${response.statusCode}',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to fetch orders: $e');
//       debugPrint('Fetch orders error: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

// import 'dart:convert';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:tm_store_app/feastures/shop/models/order_model.dart';
// import 'package:tm_store_app/service/global_variables.dart';
// import 'package:tm_store_app/service/manage_http_response.dart';

// class OrderController extends GetxController {
//   final orderM = <OrderModel>[].obs;
//   final isLoading = false.obs;
//   final bool isUpdate;
//   final String? buyerId;

//   OrderController({this.isUpdate = false, this.buyerId});

//   @override
//   void onInit() {
//     super.onInit();
//     // Fetch orders dynamically for the logged-in user on initialization
//     if (buyerId != null && buyerId!.isNotEmpty) {
//       fetchOrders(buyerId: buyerId);
//     }
//   }

//   Future<void> createShippingAddress({
//     required OrderModel order,
//     required BuildContext context,
//   }) async {
//     try {
//       isLoading.value = true;

//       // Ensure buyerId is attached in payload
//       final Map<String, dynamic> bodyData = order.toMap();
//       if (buyerId != null && buyerId!.isNotEmpty) {
//         bodyData['buyerId'] = buyerId;
//       }

//       http.Response response = await http.post(
//         Uri.parse('$uri/api/saveOrUpdateAddress'),
//         headers: const {'Content-Type': 'application/json; charset=UTF-8'},
//         body: jsonEncode(bodyData),
//       );

//       manageHttpResponse(
//         response: response,
//         context: context,
//         onSuccess: () {
//           showSnackBar(context, 'Order address added successfully');
//           Get.snackbar('Success', 'Order address added successfully');
//           // Refresh list for the active buyer
//           fetchOrders(
//             buyerId: order.buyerId.isNotEmpty ? order.buyerId : buyerId,
//           );
//         },
//       );
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Failed to add order address',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       debugPrint('Create address error: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> updateShippingAddress({
//     required OrderModel order,
//     required BuildContext context,
//   }) async {
//     try {
//       isLoading.value = true;

//       // Send both orderId and buyerId to match backend /api/UpdateOrderAddress
//       final Map<String, dynamic> bodyData = {
//         'orderId': order.id,
//         'buyerId': order.buyerId.isNotEmpty ? order.buyerId : buyerId,
//         ...order.toMap(),
//       };

//       http.Response response = await http.post(
//         Uri.parse('$uri/api/UpdateOrderAddress'),
//         headers: const {'Content-Type': 'application/json; charset=UTF-8'},
//         body: jsonEncode(bodyData),
//       );

//       manageHttpResponse(
//         response: response,
//         context: context,
//         onSuccess: () {
//           int index = orderM.indexWhere((e) => e.id == order.id);
//           if (index != -1) {
//             orderM[index] = order;
//           } else {
//             fetchOrders(
//               buyerId: order.buyerId.isNotEmpty ? order.buyerId : buyerId,
//             );
//           }
//           showSnackBar(context, "Order address updated successfully");
//           Get.snackbar("Success", "Order address updated successfully");
//         },
//       );
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to update order address: $e');
//       debugPrint('Update address error: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> fetchOrders({String? buyerId}) async {
//     final targetBuyerId = buyerId ?? this.buyerId;

//     try {
//       isLoading.value = true;
//       final Uri endpoint =
//           targetBuyerId != null && targetBuyerId.isNotEmpty
//               ? Uri.parse('$uri/api/orders/$targetBuyerId')
//               : Uri.parse('$uri/api/orders');

//       http.Response response = await http.get(
//         endpoint,
//         headers: const {'Content-Type': 'application/json; charset=UTF-8'},
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> data = jsonDecode(response.body);
//         orderM.value = data.map((json) => OrderModel.fromMap(json)).toList();
//       } else {
//         Get.snackbar(
//           'Error',
//           'Failed to fetch orders: ${response.statusCode}',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to fetch orders: $e');
//       debugPrint('Fetch orders error: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

// import 'dart:convert';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:tm_store_app/feastures/shop/models/order_model.dart';
// import 'package:tm_store_app/service/global_variables.dart';
// import 'package:tm_store_app/service/manage_http_response.dart';

// class OrderController extends GetxController {
//   final orderM = <OrderModel>[].obs;
//   final isLoading = false.obs;
//   final bool isUpdate;
//   final String? buyerId;

//   // Holds the single saved shipping address for the buyer, used to pre-fill the edit form
//   final Rxn<OrderModel> currentAddress = Rxn<OrderModel>();

//   OrderController({this.isUpdate = false, this.buyerId});

//   @override
//   void onInit() {
//     super.onInit();
//     if (buyerId != null && buyerId!.isNotEmpty) {
//       fetchOrders(buyerId: buyerId);
//       fetchAddressByBuyerId(buyerId!);
//       if (isUpdate) {
//         fetchAddressByBuyerId(buyerId!);
//       }
//     }
//   }

//   /// Fetch the single saved shipping address for a buyer.
//   /// Matches GET /api/orderAddress/:buyerId — used to pre-fill the edit form.
//   Future<OrderModel?> fetchAddressByBuyerId(String buyerId) async {
//     try {
//       isLoading.value = true;

//       final response = await http.get(
//         Uri.parse('$uri/api/orderAddress/$buyerId'),
//         headers: const {'Content-Type': 'application/json; charset=UTF-8'},
//       );

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = jsonDecode(response.body);
//         final order = OrderModel.fromMap(data['order']);
//         currentAddress.value = order;
//         return order;
//       } else if (response.statusCode == 404) {
//         // No address saved yet — normal for first-time users
//         currentAddress.value = null;
//         return null;
//       } else {
//         Get.snackbar(
//           'Error',
//           'Failed to fetch address: ${response.statusCode}',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//         return null;
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to fetch address: $e');
//       debugPrint('Fetch address error: $e');
//       return null;
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> createShippingAddress({
//     required OrderModel order,
//     required BuildContext context,
//   }) async {
//     try {
//       isLoading.value = true;

//       final Map<String, dynamic> bodyData = order.toMap();
//       final resolvedBuyerId =
//           order.buyerId.isNotEmpty ? order.buyerId : buyerId;
//       if (resolvedBuyerId != null && resolvedBuyerId.isNotEmpty) {
//         bodyData['buyerId'] = resolvedBuyerId;
//       }

//       // Matches POST /api/addOrderAddress
//       http.Response response = await http.post(
//         Uri.parse('$uri/api/addOrderAddress'),
//         headers: const {'Content-Type': 'application/json; charset=UTF-8'},
//         body: jsonEncode(bodyData),
//       );

//       manageHttpResponse(
//         response: response,
//         context: context,
//         onSuccess: () {
//           showSnackBar(context, 'Order address added successfully');
//           Get.snackbar('Success', 'Order address added successfully');
//           fetchOrders(buyerId: resolvedBuyerId);
//           if (resolvedBuyerId != null) {
//             fetchAddressByBuyerId(resolvedBuyerId);
//           }
//         },
//       );
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Failed to add order address',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       debugPrint('Create address error: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> updateShippingAddress({
//     required OrderModel order,
//     required BuildContext context,
//   }) async {
//     try {
//       isLoading.value = true;

//       final resolvedBuyerId =
//           order.buyerId.isNotEmpty ? order.buyerId : buyerId;

//       if (resolvedBuyerId == null || resolvedBuyerId.isEmpty) {
//         Get.snackbar('Error', 'Missing buyerId for update');
//         return;
//       }

//       final Map<String, dynamic> bodyData = order.toMap();

//       // Matches PUT /api/updateOrderAddress/:buyerId
//       http.Response response = await http.put(
//         Uri.parse('$uri/api/updateOrderAddress/$resolvedBuyerId'),
//         headers: const {'Content-Type': 'application/json; charset=UTF-8'},
//         body: jsonEncode(bodyData),
//       );

//       manageHttpResponse(
//         response: response,
//         context: context,
//         onSuccess: () {
//           currentAddress.value = order;
//           int index = orderM.indexWhere((e) => e.buyerId == resolvedBuyerId);
//           if (index != -1) {
//             orderM[index] = order;
//           } else {
//             fetchOrders(buyerId: resolvedBuyerId);
//           }
//           showSnackBar(context, "Order address updated successfully");
//           Get.snackbar("Success", "Order address updated successfully");
//         },
//       );
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to update order address: $e');
//       debugPrint('Update address error: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   /// Fetch the buyer's order history (list).
//   /// Requires a backend route: GET /api/orders/:buyerId returning { "orders": [...] }
//   Future<void> fetchOrders({String? buyerId}) async {
//     final targetBuyerId = buyerId ?? this.buyerId;
//     if (targetBuyerId == null || targetBuyerId.isEmpty) return;

//     try {
//       isLoading.value = true;

//       final response = await http.get(
//         Uri.parse('$uri/api/orders/$targetBuyerId'),
//         headers: const {'Content-Type': 'application/json; charset=UTF-8'},
//       );

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> body = jsonDecode(response.body);
//         final List<dynamic> data = body['orders'] ?? [];
//         orderM.value = data.map((json) => OrderModel.fromMap(json)).toList();
//       } else if (response.statusCode == 404) {
//         orderM.value = [];
//       } else {
//         Get.snackbar(
//           'Error',
//           'Failed to fetch orders: ${response.statusCode}',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to fetch orders: $e');
//       debugPrint('Fetch orders error: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tm_store_app/feastures/shop/models/order_model.dart';
import 'package:tm_store_app/service/global_variables.dart';
import 'package:tm_store_app/service/manage_http_response.dart';

class OrderController extends GetxController {
  // final orderM = <OrderModel>[].obs;
  final RxList<OrderModel> orderM = <OrderModel>[].obs;
  final Rxn<OrderModel> currentAddress = Rxn<OrderModel>();
  final RxnString selectedAddressId = RxnString();

  final isLoading = false.obs;
  final bool isUpdate;
  final String? buyerId;

  // Holds the single saved shipping address for the buyer, used to pre-fill the edit form
  final _deviceStorage = GetStorage();

  // Tracks which address card is currently selected in the SelectAddress UI

  // Form field controllers - created once per Getx controller instance
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final streetController = TextEditingController();
  final postalCodeController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();

  // Track the currently selected address ID for the SelectAddress UI
  String? _loadedAddressId;

  OrderController({this.isUpdate = false, this.buyerId});
  @override
  void onInit() {
    super.onInit();
    // Listen for changes on currentAddress to auto-fill form controllers when network fetch completes
    // _loadStoredAddress();
    ever(currentAddress, (OrderModel? address) {
      if (address != null && needsPrefillFor(address)) {
        prefillFormFields(address);
      }
    });
    if (buyerId != null && buyerId!.isNotEmpty) {
      // fetchOrders(buyerId: buyerId);
      // if (isUpdate) {
      //   fetchAddressByBuyerId(buyerId!);
      // }
      _initialFetch();
    }
  }

  Future<void> _initialFetch() async {
    await fetchOrders(buyerId: buyerId);
    await fetchAddressByBuyerId(buyerId);
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    streetController.dispose();
    postalCodeController.dispose();
    cityController.dispose();
    stateController.dispose();
    countryController.dispose();
    super.onClose();
  }

  //Fills the form fields with the current address data for editing
  void prefillFormFields(OrderModel? order) {
    _loadedAddressId = order?.id;
    fullNameController.text = order?.fullName ?? '';
    emailController.text = order?.email ?? '';
    phoneNumberController.text = order?.phoneNumber ?? '';
    streetController.text = order?.street ?? '';
    postalCodeController.text = order?.postalCode ?? '';
    cityController.text = order?.city ?? '';
    stateController.text = order?.state ?? '';
    countryController.text = order?.country ?? '';
  }

  bool needsPrefillFor(OrderModel? order) {
    // return _loadedAddressId != order?.id;
    if (order == null) return false;
    final currentId = order.id.isNotEmpty ? order.id : order.buyerId;
    return _loadedAddressId != currentId;
  }

  /// Fetch the single saved shipping address for a buyer.
  /// Matches GET /api/orderAddress/:buyerId — used to pre-fill the edit form.
  Future<OrderModel?> fetchAddressByBuyerId(String? targetBuyerId) async {
    if (targetBuyerId == null || targetBuyerId.isEmpty) return null;
    try {
      isLoading.value = true;

      final response = await http.get(
        Uri.parse('$uri/api/orderAddress/$targetBuyerId'),
        headers: const {'Content-Type': 'application/json; charset=UTF-8'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final dynamic rawOrder = data['order'] ?? data;
        final order = OrderModel.fromMap(rawOrder);

        // Update reactive variables before returning
        currentAddress.value = order;
        selectedAddressId.value = order.id;
        return order;
      } else if (response.statusCode == 404) {
        // No address saved yet — normal for first-time users
        currentAddress.value = null;
        selectedAddressId.value = null;
        return null;
      } else {
        Get.snackbar(
          'Error',
          'Failed to fetch address: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch address: $e');
      debugPrint('Fetch address error: $e');
      return null;
    } finally {
      isLoading.value = false;
    }
    return null;
  }

  Future<void> createShippingAddress({
    required OrderModel order,
    required BuildContext context,
  }) async {
    try {
      isLoading.value = true;

      final Map<String, dynamic> bodyData = order.toMap();
      final resolvedBuyerId =
          order.buyerId.isNotEmpty ? order.buyerId : buyerId;
      if (resolvedBuyerId != null && resolvedBuyerId.isNotEmpty) {
        bodyData['buyerId'] = resolvedBuyerId;
      }

      // Matches POST /api/addOrderAddress
      http.Response response = await http.post(
        Uri.parse('$uri/api/addOrderAddress'),
        headers: const {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(bodyData),
      );

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Order address added successfully');
          Get.snackbar('Success', 'Order address added successfully');
          fetchOrders(buyerId: resolvedBuyerId);
          if (resolvedBuyerId != null) {
            fetchAddressByBuyerId(resolvedBuyerId);
          }
        },
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add order address',
        snackPosition: SnackPosition.BOTTOM,
      );
      debugPrint('Create address error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateShippingAddress({
    required OrderModel order,
    required BuildContext context,
  }) async {
    try {
      isLoading.value = true;

      final targetId =
          order.id.isNotEmpty
              ? order.id
              : order.buyerId.isNotEmpty
              ? order.buyerId
              : buyerId;

      if (targetId == null || targetId.isEmpty) {
        Get.snackbar('Error', 'Missing buyerId for update');
        return;
      }

      final Map<String, dynamic> bodyData = order.toMap();

      // Matches PUT /api/updateOrderAddress/:buyerId
      final endPoint =
          order.id.isNotEmpty
              ? '$uri/api/update-order/${order.id}'
              : '$uri/api/updateOrderAddress/$targetId';
      http.Response response = await http.put(
        Uri.parse(endPoint),
        headers: const {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(bodyData),
      );

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          currentAddress.value = order;
          // Find exact order index by document ID first, fallback to buyerId match
          int index = orderM.indexWhere((e) => e.id == order.id);
          if (index == -1 && order.buyerId.isNotEmpty) {
            index = orderM.indexWhere((e) => e.buyerId == order.buyerId);
          }

          if (index != -1) {
            orderM[index] = order;
          } else {
            fetchOrders(
              buyerId: order.buyerId.isNotEmpty ? order.buyerId : buyerId,
            );
          }

          showSnackBar(context, "Order address updated successfully");
          Get.snackbar("Success", "Order address updated successfully");
        },
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to update order address: $e');
      debugPrint('Update address error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Update order by specific order _id (kept for cases where you already have the order id)
  // Future<void> updateShippingAddress({required OrderModel order}) async {
  //   try {
  //     isLoading.value = true;

  //     if (order.id.isEmpty) {
  //       Get.snackbar('Error', 'Missing order ID for update');
  //       return;
  //     }

  //     http.Response response = await http.put(
  //       Uri.parse('$uri/api/update-order/${order.id}'),
  //       headers: const {'Content-Type': 'application/json; charset=UTF-8'},
  //       body: jsonEncode(order.toMap()),
  //     );

  //     if (response.statusCode == 200) {
  //       currentAddress.value = order;
  //       int index = orderM.indexWhere((e) => e.id == order.id);
  //       if (index != -1) {
  //         orderM[index] = order;
  //       } else {
  //         fetchOrders(
  //           buyerId: order.buyerId.isNotEmpty ? order.buyerId : buyerId,
  //         );
  //       }
  //       Get.snackbar("Success", "Order address updated successfully");
  //     } else {
  //       Get.snackbar(
  //         'Error',
  //         'Failed to update order address: ${response.statusCode}',
  //       );
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to update order address: $e');
  //     debugPrint('Update address error: $e');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> deleteShippingAddress({
    required String orderId,
    required BuildContext context,
  }) async {
    try {
      isLoading.value = true;

      final response = await http.delete(
        Uri.parse('$uri/api/deleteOrderAddress/$orderId'),
        headers: const {'Content-Type': 'application/json; charset=UTF-8'},
      );

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () async {
          orderM.removeWhere((order) => order.id == orderId);
          if (currentAddress.value?.id == orderId ||
              selectedAddressId.value == orderId) {
            if (orderM.isNotEmpty) {
              // Select the next available address and sync to DB
              final nextAddress = orderM.first;
              await selectShippingAddress(nextAddress);
            } else {
              currentAddress.value = null;
              selectedAddressId.value = null;
              _deviceStorage.remove('currentAddress');
            }
          }
          showSnackBar(context, 'Order address deleted successfully');
          Get.snackbar('Success', 'Order address deleted successfully');
        },
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete order address: $e');
      debugPrint('Delete address error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> selectShippingAddress(OrderModel chosenAddress) async {
    try {
      // Update reactive local state immediately for UI feedback
      selectedAddressId.value = chosenAddress.id;
      currentAddress.value = chosenAddress;

      // sync selection  to MongoDB backend
      final response = await http.put(
        Uri.parse('$uri/api/selectShippingAddress'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'buyerId': buyerId,
          'selectedAddressId': chosenAddress.id,
        }),
      );

      if (response.statusCode == 200) {
        orderM.assignAll(
          orderM.map((item) {
            return OrderModel(
              id: item.id,
              fullName: item.fullName,
              email: item.email,
              phoneNumber: item.phoneNumber,
              country: item.country,
              state: item.state,
              city: item.city,
              street: item.street,
              postalCode: item.postalCode,
              productName: item.productName,
              productPrice: item.productPrice,
              quantity: item.quantity,
              category: item.category,
              buyerId: item.buyerId,
              vendorId: item.vendorId,
              image: item.image,
              processing: item.processing,
              delivered: item.delivered,
              isSelected: item.id == chosenAddress.id,
            );
          }).toList(),
        );
        Get.snackbar('Success', 'Address selected successfully');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to select address: $e');
      debugPrint('Select address error: $e');
    }
  }

  /// Fetch the buyer's order history (list).
  /// Requires a backend route: GET /api/orders/:buyerId returning { "orders": [...] }
  Future<void> fetchOrders({String? buyerId}) async {
    final targetBuyerId = buyerId ?? this.buyerId;
    if (targetBuyerId == null || targetBuyerId.isEmpty) return;

    try {
      isLoading.value = true;

      final response = await http.get(
        Uri.parse('$uri/api/orders/$targetBuyerId'),
        headers: const {'Content-Type': 'application/json; charset=UTF-8'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        final List<dynamic> data = body['orders'] ?? [];
        final parseList = data.map((json) => OrderModel.fromMap(json)).toList();
        orderM.value = parseList;
        // Extract the explicitly selected address or fallback to first
        final selected =
            parseList.firstWhereOrNull((e) => e.isSelected == true) ??
            parseList.firstOrNull;
        if (selected != null) {
          selectedAddressId.value = selected.id;
          currentAddress.value = selected;
        } else {
          selectedAddressId.value = null;
          currentAddress.value = null;
        }
      } else if (response.statusCode == 404) {
        orderM.value = [];
        selectedAddressId.value = null;
        currentAddress.value = null;
      } else {
        Get.snackbar(
          'Error',
          'Failed to fetch orders: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch orders: $e');
      debugPrint('Fetch orders error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
