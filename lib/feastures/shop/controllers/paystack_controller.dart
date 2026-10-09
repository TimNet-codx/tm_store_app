import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tm_store_app/main_screen.dart';
import 'package:tm_store_app/service/global_variables.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:tm_store_app/common/widgets/success_screen/success_screen.dart';
import 'package:tm_store_app/utils/constants/image_strings.dart';

class PaystackController extends GetxController {
  // Replace with your local host IP during dev (e.g. http://10.0.2.2:5000 for Android emulator) or production URL
  // final String backendBaseUrl = 'https://192.168.0.120:3000/api/paystack';

  var isLoading = true.obs;
  var isWebViewReady = false.obs;
  var checkoutUrl = ''.obs;
  var reference = ''.obs;

  late final WebViewController webViewController;

  @override
  void onInit() {
    super.onInit();
    webViewController = WebViewController();
  }

  Future<void> startPaymentFlow({
    required String email,
    required double amount,
  }) async {
    isLoading.value = true;
    isWebViewReady.value = false;

    bool success = await _initializeTransaction(email: email, amount: amount);

    if (success && checkoutUrl.value.isNotEmpty) {
      _loadCheckoutUrl(checkoutUrl.value);
    }
  }

  // Future<bool> _initializeTransaction({
  //   required String email,
  //   required double amount,
  // }) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('$uri/paystack/initialize'),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({'email': email, 'amount': amount}),
  //     );

  //     final data = jsonDecode(response.body);

  //     if (data['status'] == true) {
  //       checkoutUrl.value = data['data']['authorization_url'];
  //       reference.value = data['data']['reference'];
  //       return true;
  //     } else {
  //       isLoading.value = false;
  //       Get.snackbar(
  //         'Error',
  //         data['message'] ?? 'Failed to initialize transaction',
  //       );
  //       return false;
  //     }
  //   } catch (e) {
  //     isLoading.value = false;
  //     Get.snackbar('Error', 'Unable to connect to payment server');
  //     return false;
  //   }
  // }

  Future<bool> _initializeTransaction({
    required String email,
    required double amount,
  }) async {
    try {
      print(
        "🚀 Sending Paystack initialize request to: $uri/paystack/initialize",
      );

      final response = await http
          .post(
            Uri.parse('$uri/paystack/initialize'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'email': email, 'amount': amount}),
          )
          .timeout(const Duration(seconds: 15));

      print("📩 Response Code: ${response.statusCode}");
      print("📩 Response Body: ${response.body}");

      final data = jsonDecode(response.body);

      if (data['status'] == true) {
        checkoutUrl.value = data['data']['authorization_url'];
        reference.value = data['data']['reference'];
        return true;
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          data['message'] ?? 'Failed to initialize transaction',
        );
        return false;
      }
    } catch (e) {
      print("❌ Exception in Paystack initialization: $e");
      isLoading.value = false;
      Get.snackbar('Connection Error', 'Unable to reach backend server ($e)');
      return false;
    }
  }

  void _loadCheckoutUrl(String url) {
    webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String currentUrl) => _checkUrl(currentUrl),
          onNavigationRequest: (NavigationRequest request) {
            if (_checkUrl(request.url)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));

    isLoading.value = false;
    isWebViewReady.value = true;
  }

  bool _checkUrl(String url) {
    if (url.contains('https://standard.paystack.co/close') ||
        url.contains('callback')) {
      _handlePaymentVerification();
      return true;
    }
    return false;
  }

  Future<void> _handlePaymentVerification() async {
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    bool isVerified = await _verifyTransaction(reference.value);
    Get.back();

    if (isVerified) {
      Get.offAll(
        () => SuccessScreen(
          image: TImages.successfulPaymentIcon,
          title: 'Payment Successful!',
          subTitle: 'Your transaction was completed via Paystack.',
          onPressed: () => Get.offAll(() => MainScreen()),
        ),
      );
    } else {
      Get.snackbar(
        'Payment Failed',
        'Transaction could not be verified. Please try again.',
      );
    }
  }

  Future<bool> _verifyTransaction(String ref) async {
    try {
      final response = await http.get(Uri.parse('$uri/paystack/verify/$ref'));

      final data = jsonDecode(response.body);
      return data['status'] == true;
    } catch (e) {
      return false;
    }
  }
}
