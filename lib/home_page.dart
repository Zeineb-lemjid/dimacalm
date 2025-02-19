import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/home_screen.dart';
import 'screens/activities_screen.dart';
import 'screens/profile_screen.dart';
import 'controller.dart';

class HomePage extends StatelessWidget {
  HomeController homeController =
      Get.put(HomeController()); // Initialize the controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mental Health App')),
      body: Obx(() {
        // Use Obx to listen to changes in selectedIndex
        return _pages[homeController.selectedIndex.value];
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: homeController.selectedIndex.value,
        onTap: homeController.updateIndex, // Call the update method
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Activities'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  final List<Widget> _pages = [
    const HomeScreen(),
    const ActivitiesScreen(),
    const ProfileScreen(),
  ];
}
