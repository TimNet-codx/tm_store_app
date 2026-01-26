  import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tm_store_app/veiws/screens/nav_screens/cart/cart_screen.dart';
import 'package:tm_store_app/veiws/screens/nav_screens/category/category_screen.dart';
import 'package:tm_store_app/veiws/screens/nav_screens/favorite/favorite_screen.dart';
import 'package:tm_store_app/veiws/screens/nav_screens/home/home_screen.dart';
import 'package:tm_store_app/veiws/screens/nav_screens/account/account_screen.dart';
import 'package:tm_store_app/veiws/screens/nav_screens/stores/stores_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
 int _pageIndex = 0;
 final List<Widget> _pages = [
   HomeScreen(),
   FavoriteScreen(),
   CategoryScreen(),
   StoresScreen(),
   CartScreen(),
   AccountScreen(),
 ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     bottomNavigationBar: BottomNavigationBar(
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      currentIndex: _pageIndex,
      onTap: (value) {
        setState(() {
          _pageIndex = value;
        });
      },
      type: BottomNavigationBarType.fixed, 
      items: [
      BottomNavigationBarItem(icon: Icon(Iconsax.home), label: 'Home',),
      BottomNavigationBarItem(icon: Icon(Iconsax.heart),  label: 'Favorite',),
      BottomNavigationBarItem(icon: Icon(Iconsax.category),  label: 'Categories',),
      BottomNavigationBarItem(icon: Icon(Iconsax.shop), label: 'Stores',),
      BottomNavigationBarItem(icon: Icon(Iconsax.shopping_bag),  label: 'Cart',),
      BottomNavigationBarItem(icon: Icon(Iconsax.user),  label: 'Account',),
     ],),

     body: _pages[_pageIndex],
    );
  }
}