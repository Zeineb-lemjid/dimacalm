import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/home_screen.dart';
import '../screens/activities_screen.dart';
import '../screens/profile_screen.dart';
import '../controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  final List<Widget> _pages = [
    HomeScreen(),
    ActivitiesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _pages[homeController.selectedIndex.value]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: homeController.selectedIndex.value,
        onTap: (index) => homeController.updateIndex(index),
        selectedItemColor: Colors.teal, // Highlight selected tab
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: false, // Hide text for unselected items
        type: BottomNavigationBarType.fixed, // Prevents shifting effect
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Activities'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
