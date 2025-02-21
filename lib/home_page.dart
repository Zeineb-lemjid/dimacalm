import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'screens/activities_screen.dart';
import 'screens/profile_screen.dart';
import 'controllers/navigation_controller.dart';
import 'screens/mood_screen.dart';

class HomePage extends StatelessWidget {
  final NavigationController navController = Get.put(NavigationController());

  final List<Widget> _pages = [
    const HomeScreen(),
    const ActivitiesScreen(),
    ProfileScreen(),
    MoodScreen(),
  ];

   HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DIMACALM',
          style: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // You can navigate to a Settings page here
              // For now, it will just print a message
              print("Settings tapped");
            },
          ),
        ],
      ),
      body: Obx(() => AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _pages[navController.selectedIndex.value],
          )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: navController.selectedIndex.value,
            onTap: navController.changeIndex,
            selectedItemColor: Colors.blue, // Change to active color
            unselectedItemColor: Colors.grey, // Change to inactive color
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.blue,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Activities',
                backgroundColor: Colors.green,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
                backgroundColor: Colors.red,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.mood),
                label: 'Mood',
                backgroundColor: Colors.yellow,
              ),
            ],
          )),
    );
  }
}
