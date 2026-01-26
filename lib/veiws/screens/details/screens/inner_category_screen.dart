// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
// import 'package:tm_store_app/controllers/subCategory_controller.dart';
// import 'package:tm_store_app/models/category_model.dart';
// import 'package:tm_store_app/veiws/screens/details/screens/widget/inner_category_content_widget.dart';
// import 'package:tm_store_app/veiws/screens/nav_screens/cart/cart_screen.dart';
// import 'package:tm_store_app/veiws/screens/nav_screens/category/category_screen.dart';
// import 'package:tm_store_app/veiws/screens/nav_screens/favorite/favorite_screen.dart';
// import 'package:tm_store_app/veiws/screens/nav_screens/account/account_screen.dart';
// import 'package:tm_store_app/veiws/screens/nav_screens/stores/stores_screen.dart';

// class InnerCategoryScreen extends StatefulWidget {
//   final CategoryMode category; 
//   const InnerCategoryScreen({super.key, required this.category});

//   @override
//   State<InnerCategoryScreen> createState() => _InnerCategoryScreenState();
// }

// class _InnerCategoryScreenState extends State<InnerCategoryScreen> {
//   int pageIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     // ✅ Initialize controller and fetch data once when the screen loads
//     final subCategoryController = Get.put(SubCategoryController());
//     subCategoryController.fetchProductsByCategoriesName(widget.category.name);
//   }

//   @override
//   Widget build(BuildContext context) {
//     // ✅ Use widget.category to access data from the parent StatefulWidget
//     final List<Widget> pages = [
//       InnerCategoryContentWidget(category: widget.category), 
//       const FavoriteScreen(),
//       const CategoryScreen(),
//       const StoresScreen(),
//       const CartScreen(),
//       const AccountScreen(),
//     ];

//     return Scaffold(
//       appBar: TAppBar(
//         // ✅ Changed 'category.name' to 'widget.category.name'
//         title: Text(
//           widget.category.name,
//           style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.black),
//         ),
//         showBackArrow: true,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.grey,
//         currentIndex: pageIndex,
//         onTap: (value) {
//           setState(() {
//             pageIndex = value;
//           });
//         },
//         type: BottomNavigationBarType.fixed,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Iconsax.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Iconsax.heart), label: 'Favorite'),
//           BottomNavigationBarItem(icon: Icon(Iconsax.category), label: 'Categories'),
//           BottomNavigationBarItem(icon: Icon(Iconsax.shop), label: 'Stores'),
//           BottomNavigationBarItem(icon: Icon(Iconsax.shopping_bag), label: 'Cart'),
//           BottomNavigationBarItem(icon: Icon(Iconsax.user), label: 'Account'),
//         ],
//       ),
//       body: pages[pageIndex],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
import 'package:tm_store_app/controllers/subCategory_controller.dart';
import 'package:tm_store_app/models/category_model.dart';
import 'package:tm_store_app/veiws/screens/details/screens/widget/inner_category_content_widget.dart';
import 'package:tm_store_app/veiws/screens/nav_screens/cart/cart_screen.dart';
import 'package:tm_store_app/veiws/screens/nav_screens/category/category_screen.dart';
import 'package:tm_store_app/veiws/screens/nav_screens/favorite/favorite_screen.dart';
import 'package:tm_store_app/veiws/screens/nav_screens/account/account_screen.dart';
import 'package:tm_store_app/veiws/screens/nav_screens/stores/stores_screen.dart';

class InnerCategoryScreen extends StatelessWidget {
  final CategoryMode category;
  const InnerCategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    // ✅ Use Get.find if it exists, otherwise Get.put
    final controller = Get.put(SubCategoryController());
    
    // Fetch data immediately
    controller.fetchProductsByCategoriesName(category.name);

    final List<Widget> pages = [
      InnerCategoryContentWidget(category: category),
      const FavoriteScreen(),
      const CategoryScreen(),
      const StoresScreen(),
      const CartScreen(),
      const AccountScreen(),
    ];

    return Obx(() => Scaffold(
      appBar: TAppBar(
        title: Text(
          category.name,
          style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.white60),
        ),
        showBackArrow: true,
      ),
      body: pages[controller.pageIndex.value],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: controller.pageIndex.value,
        onTap: (index) => controller.changePage(index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Iconsax.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Iconsax.heart), label: 'Favorite'),
          BottomNavigationBarItem(icon: Icon(Iconsax.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Iconsax.shop), label: 'Stores'),
          BottomNavigationBarItem(icon: Icon(Iconsax.shopping_bag), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Iconsax.user), label: 'Account'),
        ],
      ),
    ));
  }
}