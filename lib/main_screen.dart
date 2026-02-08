  import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tm_store_app/feastures/personalization/views/account/account_screen.dart';
import 'package:tm_store_app/feastures/personalization/views/favorite/favorite_screen.dart';
import 'package:tm_store_app/feastures/shop/views/cart/cart_screen.dart';
import 'package:tm_store_app/feastures/shop/views/category/category_screen.dart';
import 'package:tm_store_app/feastures/shop/views/home/home_screen.dart';
import 'package:tm_store_app/feastures/shop/views/stores/stores_screen.dart';
import 'package:tm_store_app/mainNavigation_controller.dart';


// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//  int _pageIndex = 0;
//  final List<Widget> _pages = [
//    HomeScreen(),
//    FavoriteScreen(),
//    CategoryScreen(),
//    StoresScreen(),
//    CartScreen(),
//    AccountScreen(),
//  ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//      bottomNavigationBar: BottomNavigationBar(
//       selectedItemColor: Colors.blue,
//       unselectedItemColor: Colors.grey,
//       currentIndex: _pageIndex,
//       onTap: (value) {
//         setState(() {
//           _pageIndex = value;
//         });
//       },
//       type: BottomNavigationBarType.fixed, 
//       items: [
//       BottomNavigationBarItem(icon: Icon(Iconsax.home), label: 'Home',),
//       BottomNavigationBarItem(icon: Icon(Iconsax.heart),  label: 'Favorite',),
//       BottomNavigationBarItem(icon: Icon(Iconsax.category),  label: 'Categories',),
//       BottomNavigationBarItem(icon: Icon(Iconsax.shop), label: 'Stores',),
//       BottomNavigationBarItem(icon: Icon(Iconsax.shopping_bag),  label: 'Cart',),
//       BottomNavigationBarItem(icon: Icon(Iconsax.user),  label: 'Account',),
//      ],),

//      body: _pages[_pageIndex],
//     );
//   }
// }


class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  // ✅ SAME METHOD: Get.put controller
  final MainNavigationController controller = Get.put(MainNavigationController());

  final List<Widget> pages = [
    const HomeScreen(),
    const FavoriteScreen(),
    const CategoryScreen(),
    const StoresScreen(),
    const CartScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: pages[controller.pageIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.pageIndex.value,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            onTap: controller.changePage,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.heart), label: 'Favorite'),
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.category), label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.shop), label: 'Stores'),
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.shopping_bag), label: 'Cart'),
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.user), label: 'Account'),
            ],
          ),
        ));
  }
}