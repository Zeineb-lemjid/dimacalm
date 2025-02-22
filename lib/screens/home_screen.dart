import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dimacalm/screens/activities_screen.dart';
import 'profile_screen.dart';
import 'mood_screen.dart';
import '../controllers/navigation_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Welcome to Your Mental Health App',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Text('Track your mood, meditate, and stay positive!'),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final NavigationController navController = Get.put(NavigationController());

  final List<Widget> _pages = [
    const HomeScreen(),
    ActivitiesScreen(),
    ProfileScreen(),
    MoodScreen(), // Added MoodScreen from dev branch
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
              // Handle settings tap
              print("Settings tapped");
              
            },
          ),
        ],
      ),
      body: Obx(() => AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _pages[navController.selectedIndex.value], // Use NavigationController for page switching
      )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        currentIndex: navController.selectedIndex.value, // Use selectedIndex from NavigationController
        onTap: navController.changeIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
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
