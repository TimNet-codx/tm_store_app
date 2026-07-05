// // import 'dart:convert';

// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:get/get.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:tm_store_app/feastures/authentication/controllers/user_controller.dart';
// // import 'package:tm_store_app/feastures/authentication/views/login/login.dart';
// // import 'package:tm_store_app/provider/cart_provider.dart';
// // import 'package:tm_store_app/provider/user_provider.dart';
// // import 'package:tm_store_app/utils/helpers/network_manager.dart';
// // import 'package:tm_store_app/utils/theme/theme.dart';
// // import 'package:tm_store_app/main_screen.dart';

// // void main() {
// //   // Run The App Wrapped in a ProviderScope to enable Riverpod State Management
// //   WidgetsFlutterBinding.ensureInitialized();
// //   Get.put(NetworkManager(), permanent: true);
// //   Get.put(UserController());
// //   runApp(ProviderScope(child: const MyApp()));
// // }
// // // Root Widget of the App,  a ConsumerWidget to consume state chnages i.e it was changed from StatelessWidget to ConsumerWidget
// // class MyApp extends ConsumerWidget {
// //   const MyApp({super.key});

// //   // Method to check the token and set the user data if available
// //   Future<void> _checkTokenAndSetUser(WidgetRef ref) async {
// //     // Obtain an instance of SharedPreferences for local data storage
// //      SharedPreferences preferences = await SharedPreferences.getInstance();
// //      // Retrieve the stored authentication token and user data locally

// //      String? token = preferences.getString('auth-token',);
// //      String? userJson = preferences.getString('user',);

// //      // if both token and user data are available, update user state
// //      if (token != null && userJson != null) {
// //        ref.read(userProvider.notifier).setUser(userJson);
// //        try{
// //         final Map<String, dynamic> userData = jsonDecode(userJson);
// //         final String userId = userData['id'] ?? userData['_id'] ?? '';
// //         if(userId.isNotEmpty){
// //           await ref.read(cartProvider.notifier).syncCartToDatabase(userId);
// //           await ref.read(cartProvider.notifier).loadUserCart(userId);
// //         }

// //        }catch(e){
// //          print("Error: $e");
// //        }
// //      }else{
// //       ref.read(userProvider.notifier).signOut();
// //       ref.read(cartProvider.notifier).clearCart();
// //      }

// //   }
// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     return GetMaterialApp(
// //       title: 'TM Store App',
// //       debugShowCheckedModeBanner: false,
// //       // theme: ThemeData(
// //       //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
// //       // ),
// //       themeMode: ThemeMode.system,
// //       theme: TAppTheme.lightTheme,
// //       darkTheme: TAppTheme.darkTheme,
// //       //home: LoginScreen()
// //       home: FutureBuilder(
// //         future: _checkTokenAndSetUser(ref),
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return const Center(
// //               child: CircularProgressIndicator(),
// //             );
// //           }
// //           final user = ref.watch(userProvider);
// //           return user != null ? MainScreen() : LogInScreen();
// //         },
// //       ),

// //     );
// //   }
// // }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tm_store_app/bindings/general_bindings.dart';
// import 'package:tm_store_app/feastures/authentication/controllers/user_controller.dart';
// import 'package:tm_store_app/feastures/authentication/views/login/login.dart';
// import 'package:tm_store_app/feastures/authentication/views/onboarding/onboarding.dart';
// import 'package:tm_store_app/provider/cart_provider.dart';
// import 'package:tm_store_app/provider/user_provider.dart';
// import 'package:tm_store_app/utils/constants/colors.dart';
// import 'package:tm_store_app/utils/helpers/network_manager.dart';
// import 'package:tm_store_app/utils/theme/theme.dart';
// import 'package:tm_store_app/main_screen.dart';

// void main() async {
//   // Ensure framework services are initialized prior to shared preferences check
//   // (Fixes Async state engine racing crashes)
//    final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

//    await Get.putAsync<SharedPreferences>(() async {
//     return await SharedPreferences.getInstance();
//   });

//   // Initialize permanent GetX utilities
//   Get.put(NetworkManager(), permanent: true);
//   Get.put(UserController());

//   // Preserve splash until setup is done
//   FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

//   // 1. Fetch persistent session variables securely prior to rendering any UI
//   final preferences = await SharedPreferences.getInstance();
//   final String? token = preferences.getString('auth-token');
//   final String? userJson = preferences.getString('user');

// // to get user data from shared preferences and set it to the user provider at the app startup
// final userController = Get.put(UserController());
// userController.hydrateUserFromCache(userJson);
//   runApp(
//     ProviderScope(
//       child: MyApp(
//         initialToken: token,
//         initialUserJson: userJson,
//       ),
//     ),
//   );
// }

// class MyApp extends ConsumerWidget {
//   final String? initialToken;
//   final String? initialUserJson;

//   const MyApp({
//     super.key,
//     this.initialToken,
//     this.initialUserJson
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // 2. Safely seed the user session data into the Riverpod state graph
//     // We execute this immediately inside a post-frame lifecycle callback
//     // to keep it from blocking or fighting with the rendering phase.
//     if (initialToken != null && initialUserJson != null) {
//       WidgetsBinding.instance.addPostFrameCallback((_) async {
//         // Hydrate your global user provider state engine
//         ref.read(userProvider.notifier).setUser(initialUserJson!);

//         try {
//           final Map<String, dynamic> userData = jsonDecode(initialUserJson!);
//           // Fallback parsing handles structural schema variations cleanly
//           final String userId = userData['id'] ?? userData['_id'] ?? '';

//           if (userId.isNotEmpty) {
//             print("🚀 App Startup Hydration Success -> Sourced Valid User ID: '$userId'");
//             await ref.read(cartProvider.notifier).loadUserCart(userId);
//             await ref.read(cartProvider.notifier).syncCartToDatabase(userId);
//             //await ref.read(cartProvider.notifier).removeCartItemFromDatabase( , userId: userId);
//           }
//         } catch (e) {
//           print("⚠️ Error parsing runtime user session state payload: $e");
//         }
//       });
//     } else {
//       // Clear states cleanly if session components are empty
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         ref.read(userProvider.notifier).signOut();
//         // ref.read(cartProvider.notifier).clearCart();
//       });
//     }

//     // Determine clean routing map target context
//     final bool isSessionActive = initialToken != null && initialToken!.isNotEmpty && initialUserJson != null;

//     return GetMaterialApp(
//       title: 'TM Store App',
//       debugShowCheckedModeBanner: false,
//       themeMode: ThemeMode.system,
//       theme: TAppTheme.lightTheme,
//       darkTheme: TAppTheme.darkTheme,
//       initialBinding: GeneralBindings(),
//       // 3. FIX: Standard structural root selection drops the volatile FutureBuilder
//        //home: isSessionActive ?  MainScreen() :  LogInScreen(),
//        home: const OnBoardingScreen(),
//       // home: isSessionActive ?  LogInScreen() :  Scaffold(backgroundColor: TColors.primary, body: Center(child: CircularProgressIndicator(color: Colors.white))),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tm_store_app/bindings/general_bindings.dart';
import 'package:tm_store_app/feastures/authentication/controllers/user_controller.dart';
import 'package:tm_store_app/feastures/authentication/views/login/login.dart';
import 'package:tm_store_app/feastures/authentication/views/onboarding/onboarding.dart';
import 'package:tm_store_app/provider/cart_provider.dart';
import 'package:tm_store_app/provider/user_provider.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/helpers/network_manager.dart';
import 'package:tm_store_app/utils/theme/theme.dart';
import 'package:tm_store_app/main_screen.dart';

void main() async {
  // Ensure framework services are initialized prior to shared preferences check
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (FlutterErrorDetails details) {
    if (details.exception is AssertionError && details.exception.toString().contains('_pressedKeys')) {
      return; // ignore this specific harmless assertion
    }
    FlutterError.presentError(details);
  };
  // Initialize and register SharedPreferences instance with GetX
  final preferences = await Get.putAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });

  // Initialize permanent GetX utilities
  Get.put(NetworkManager(), permanent: true);
  Get.put(UserController());

  // Preserve splash until setup is done
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Fetch persistent session variables securely prior to rendering any UI
  final String? token = preferences.getString('auth-token');
  final String? userJson = preferences.getString('user');

  // 1. READ THE ONBOARDING STATUS FLAG (Defaults to true if it doesn't exist yet)
  final bool isFirstTime = preferences.getBool('IsFirstTime') ?? true;

  // Hydrate GetX user controller state
  final userController = Get.find<UserController>();
  userController.hydrateUserFromCache(userJson);

  // Remove the native splash screen as we are ready to build the UI
  // FlutterNativeSplash.remove();

  runApp(
    ProviderScope(
      child: MyApp(
        initialToken: token,
        initialUserJson: userJson,
        isFirstTime: isFirstTime, // 2. PASS IT DOWN TO MYAPP
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  final String? initialToken;
  final String? initialUserJson;
  final bool isFirstTime;

  const MyApp({super.key, this.initialToken, this.initialUserJson, required this.isFirstTime});

  /// This async method acts as our background initializer engine
  Future<void> _initializeAppStartup(WidgetRef ref) async {
    // 1. Immediately drop the native platform splash view as Flutter is ready to paint
    FlutterNativeSplash.remove();

    // 2. Seed and hydrate the user session data into the Riverpod state graph
    if (initialToken != null && initialUserJson != null) {
      // ref.read(userProvider.notifier).setUser(initialUserJson!);
      //Delay provider modification until the frame is fully built
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(userProvider.notifier).setUser(initialUserJson!);
      });
      try {
        final Map<String, dynamic> userData = jsonDecode(initialUserJson!);
        final String userId = userData['id'] ?? userData['_id'] ?? '';

        if (userId.isNotEmpty) {
          // Await both operations sequentially so the spinner keeps spinning until data settles
          await ref.read(cartProvider.notifier).loadUserCart(userId);
          await ref.read(cartProvider.notifier).syncCartToDatabase(userId);
        }
      } catch (e) {
        print("⚠️ Error parsing runtime user session state payload: $e");
      }
    } else {
      // ref.read(userProvider.notifier).signOut();
      // Delay the signOut provider modification until post-frame as well
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(userProvider.notifier).signOut();
      });
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isSessionActive = initialToken != null && initialToken!.isNotEmpty && initialUserJson != null;

    return GetMaterialApp(
      title: 'TM Store App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialBinding: GeneralBindings(),

      // 3. The FutureBuilder replaces state management cleanly
      home: FutureBuilder(
        future: _initializeAppStartup(ref),
        builder: (context, snapshot) {
          // While your cart sync and auth hydration are running:
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(backgroundColor: TColors.primary, body: const Center(child: CircularProgressIndicator(color: Colors.white)));
          }

          // Once initialization finishes successfully, route to the correct screen:
          return isFirstTime ? const OnBoardingScreen() : (isSessionActive ? MainScreen() : const LogInScreen());
        },
      ),
    );
  }
}
