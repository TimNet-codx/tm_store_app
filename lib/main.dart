import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tm_store_app/feastures/authentication/views/login/login.dart';
import 'package:tm_store_app/provider/user_provider.dart';
import 'package:tm_store_app/utils/helpers/network_manager.dart';
import 'package:tm_store_app/utils/theme/theme.dart';
import 'package:tm_store_app/main_screen.dart';


void main() {
  // Run The App Wrapped in a ProviderScope to enable Riverpod State Management
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(NetworkManager(), permanent: true);
  runApp(ProviderScope(child: const MyApp()));
}
// Root Widget of the App,  a ConsumerWidget to consume state chnages i.e it was changed from StatelessWidget to ConsumerWidget
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // Method to check the token and set the user data if available
  Future<void> _checkTokenAndSetUser(WidgetRef ref) async {
    // Obtain an instance of SharedPreferences for local data storage
     SharedPreferences preferences = await SharedPreferences.getInstance();
     // Retrieve the stored authentication token and user data locally

     String? token = preferences.getString('auth-token',);
     String? userJson = preferences.getString('user',);
     
     // if both token and user data are available, update user state
     if (token != null && userJson != null) {
       ref.read(userProvider.notifier).setUser(userJson);
     }else{
      ref.read(userProvider.notifier).signOut();
     }

  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GetMaterialApp(
      title: 'TM Store App',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      // ),
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      //home: LoginScreen()
      home: FutureBuilder(
        future: _checkTokenAndSetUser(ref),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } 
          final user = ref.watch(userProvider);
          return user != null ? MainScreen() : LogInScreen();
        },
      ),

    ); 
  }
}

